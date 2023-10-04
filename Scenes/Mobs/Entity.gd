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
