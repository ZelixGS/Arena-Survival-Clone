extends Node

enum Direction {UP, DOWN, LEFT, RIGHT}

var parent: CharacterBody2D
var player: Player
var shape: CircleShape2D

@export var speed: float = 1000

@export_group("Behavior")
@export var chase_player: bool = true
@export var move_direction: Direction = Direction.RIGHT

@export_subgroup("Wavey Movement")
@export var wavey: bool = false
@export var wave_frequency: float = 2.0
@export var wave_amplitude: float = 1.5

@export_subgroup("Soft Collision")
@export var use_soft_collision: bool = true
@export var soft_collision_force: float = 800
@onready var soft_timer: Timer = $Timer

func _ready() -> void:
	player = G.get_player()
	parent = get_parent()

	shape = CircleShape2D.new()
	shape.radius = 10

	parent.max_slides = 1
	
func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	
	var direction: Vector2 = Vector2.ZERO

	if chase_player:
		direction += move_to_player()
	else:
		direction += move_straight()

	if use_soft_collision and soft_timer.is_stopped():
		direction += soft_collide()
	
	parent.velocity = direction * speed * delta
	parent.move_and_slide()

func move_to_player() -> Vector2:
	return (player.global_position - parent.global_position).normalized()

func move_straight() -> Vector2:
	match move_direction:
		Direction.UP:
			return Vector2(get_sine(), -1)
		Direction.DOWN:
			return Vector2(get_sine(), 1)
		Direction.LEFT:
			return Vector2(-1, get_sine())
		Direction.RIGHT:
			return Vector2(1, get_sine())
		_:
			return Vector2.ZERO

func get_sine() -> float:
	return sin(Clock.normal_time * wave_frequency) * wave_amplitude if wavey else 0.0

func soft_collide() -> Vector2:
	var shape_rid: RID = get_shape_rid()
	var params: PhysicsShapeQueryParameters2D = get_shapequery_params(shape_rid)
	var space_state: PhysicsDirectSpaceState2D = parent.get_world_2d().direct_space_state
	var areas: Array[Dictionary] = space_state.intersect_shape(params, 1)
	PhysicsServer2D.free_rid(shape_rid)

	var push: Vector2 = Vector2.ZERO

	if areas.size() > 0:
		var neighbor: Node2D = areas[0]["collider"]
		var push_vector: Vector2 = neighbor.global_position.direction_to(parent.global_position) 
		push = push_vector * soft_collision_force

	soft_timer.start(0.2)
	return push

func get_shape_rid() -> RID:
	var shape_rid: RID = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape_rid, shape.radius + 2)
	return shape_rid

func get_shapequery_params(shape_rid: RID) -> PhysicsShapeQueryParameters2D:
	var params = PhysicsShapeQueryParameters2D.new()
	params.shape_rid = shape_rid
	params.collide_with_bodies = true
	params.collision_mask = parent.collision_layer
	params.transform = parent.get_transform()
	params.exclude = [self]
	return params
