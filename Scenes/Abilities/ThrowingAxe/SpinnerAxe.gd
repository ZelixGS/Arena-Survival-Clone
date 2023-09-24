extends Projectile

@onready var sprite_2d: Sprite2D = $Sprite2D

var spawn: Vector2
@export var damage = 2
@export var max_radius: float = 100
@export var random_factor: float = 1.2
@export var my_duration: float = 3
var random_radius: float

func _ready() -> void:
	spawn = global_position
	hitbox_component.damage = damage
	var tween = create_tween()
	tween.tween_method(method, 0.0, 2.0, my_duration)
	tween.tween_callback(queue_free)

func method(rotations: float) -> void:
	var percent = rotations / 2
	var current_radius = percent * max_radius
	var current_direction = Vector2.RIGHT.rotated(rotations * TAU)
	global_position = spawn + (current_direction * current_radius)
	if percent > 75:
		sprite_2d.modulate.a = lerp(sprite_2d.modulate.a, 0, 0.1)

func _on_hitbox_component_struck() -> void:
	call_deferred("queue_free")
