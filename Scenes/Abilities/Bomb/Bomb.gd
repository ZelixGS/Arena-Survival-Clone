extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion: Resource = preload("res://scenes/Abilities/Bomb/BombExplosion.tscn")

@export var damage: int = 12
@export var duration: float = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var target_position: Vector2 = get_global_mouse_position()
	var tween_throw: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween_throw.tween_property(self, "position", target_position, duration)
	tween_throw.tween_callback(explode)
	
	var base_scale = scale
	var tween_scale: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween_scale.tween_property(sprite_2d, "scale", base_scale * 1.5, duration / 2)
	tween_scale.tween_property(sprite_2d, "scale", base_scale, duration / 2)

func explode() -> void:
	Create.projectile(explosion, transform)
	call_deferred("queue_free")
