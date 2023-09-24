extends Projectile

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_strike(_area: Area2D) -> void:
	stop_movement = true
	animation_player.stop()
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sprite_2d, "modulate:a", 0, 0.2)
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	call_deferred("queue_free")
