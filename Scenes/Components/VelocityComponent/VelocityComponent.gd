extends Area2D

var player: Player
var shape: CircleShape2D

@export var speed: float = 16
@export var soft_collision_force: float = 800

@onready var timer: Timer = $Timer

func _ready() -> void:
	player = G.get_player()
	shape = CircleShape2D.new()
	shape.radius = 10
	
	
