extends CharacterBody2D

@export var base: Dictionary = {
	"damage": 10,
	"health": 10,
	"speed": 1600,
	"knockback_resistance": 1.0,
}

var soft_collision_force: float = 400

@onready var player: Player = G.get_player()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	max_slides = 1

func _physics_process(delta: float) -> void:
	var direction: Vector2 = (player.global_position - global_position).normalized()
	if timer.is_stopped():
		var shape_rid: RID = PhysicsServer2D.circle_shape_create()
		PhysicsServer2D.shape_set_data(shape_rid, collision_shape_2d.shape.radius + 2)
		
		var params = PhysicsShapeQueryParameters2D.new()
		params.shape_rid = shape_rid
		params.collide_with_bodies = true
		params.collision_mask = collision_layer
		params.transform = get_transform()
		params.exclude = [self]
		var space_state = get_world_2d().direct_space_state
		var areas: Array[Dictionary] = space_state.intersect_shape(params, 1)
		if areas.size() > 0:
			var neighbor: Node2D = areas[0]["collider"]
			var push_vector: Vector2 = neighbor.global_position.direction_to(global_position) 
			direction += push_vector * soft_collision_force * delta
		PhysicsServer2D.free_rid(shape_rid)
		timer.start(0.2)
	
	velocity = direction * base["speed"] * delta
	move_and_slide()
