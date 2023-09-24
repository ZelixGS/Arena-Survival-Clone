extends CharacterBody2D
class_name Entity

@export var properties: EntityProperties = EntityProperties.new()

@onready var player: Player = G.get_player()
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	set_name.call_deferred(properties.mob_name)
	collision_layer = properties.layers_2d_physics
	collision_mask = properties.layers_2d_physics
	sprite_2d.texture = properties.mob_sprite
	animation_player.play(properties.animation)
	sprite_2d.modulate = properties.color
	health_component.max_health = properties.health
	hitbox_component.damage = properties.damage
	max_slides = 1

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	var direction: Vector2 = (player.global_position - global_position).normalized()
	if properties.use_soft_collision and timer.is_stopped():
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
			direction += push_vector * properties.soft_collision_force * delta
		PhysicsServer2D.free_rid(shape_rid)
		timer.start(0.2)
	
	velocity = direction * properties.speed * delta
	move_and_slide()
