extends Node2D

var reticle: PackedScene = preload("res://Scenes/Test/Reticle.tscn")

@onready var children: Node2D = $Children

func _on_h_slider_value_changed(value: float) -> void:
	for i in children.get_children():
		i.queue_free()
	for i in int(value):
		var node = reticle.instantiate()
		node.global_position = get_snapped_angle(i, value, global_position, 16.0)
		children.add_child(node)

func get_snapped_angle(value: int, steps:int, pos: Vector2, radius: float) -> Vector2:
	var snap = 2 * PI / steps
	return pos + Vector2(radius, 0).rotated(snap * value)
