extends CharacterBody2D
class_name Player

@export var speed = 80
@onready var reticle: Sprite2D = $Axis/Reticle
@onready var axis: Node2D = $Axis

@onready var health_component: Node = $HealthComponent

func _ready() -> void:
	health_component.connect("health_changed", health_changed)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * speed
	move_and_slide()
#	global_position = global_position.round()

func health_changed(current: int, max: int) -> void:
	Events.emit_signal("ui_health", current, max)
