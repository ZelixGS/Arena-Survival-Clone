extends Label
class_name FloatingText

func create(value: String, duration: float, travel: Vector2, spread: float, critical: bool = false) -> void:
	text = value
	if critical:
		text += "!"
	var _movement = travel.rotated((randf_range(-spread, spread)))
	pivot_offset = size/2
	float_away(travel, duration)

func float_away(movement: Vector2, duration: float = 0.2) -> void:
	var a = global_position
	var b = movement * 36
	var c = a+b
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(self, "global_position", c, duration)
	tween.parallel().tween_property(self, "modulate:a", 0.0, duration)
	tween.tween_callback(queue_free)
