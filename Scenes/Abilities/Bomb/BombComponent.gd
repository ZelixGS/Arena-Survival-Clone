extends Node

var bomb: Resource = preload("res://scenes/Abilities/Bomb/Bomb.tscn")

@onready var timer: Timer = $Timer

@export var cooldown: float = 2.5

func activate(spawn: Transform2D) -> void:
	if timer.is_stopped():
		Create.projectile(bomb, spawn)
		timer.start(2.5)
