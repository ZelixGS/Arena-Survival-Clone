extends VBoxContainer

var block: PackedScene = preload("res://Scenes/UI/Inventory/StatPanel/Statblock.tscn")

func _ready() -> void:
	remove_children()
	for i in Stats._base:
#		print(i)
		var b: HBoxContainer = block.instantiate()
		b._name = i 
		add_child(b)

func remove_children() -> void:
	for i in get_children():
		i.queue_free()
