class_name DropComponent extends Node

var experience: PackedScene = preload("res://Scenes/Pickups/Experience/ExperiencePotion.tscn")

func drop() -> void:
	Create.node(experience, owner.global_transform)
