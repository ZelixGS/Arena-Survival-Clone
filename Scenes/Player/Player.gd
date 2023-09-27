extends CharacterBody2D
class_name Player

@export var speed = 80
@onready var reticle: Sprite2D = $Axis/Reticle
@onready var axis: Node2D = $Axis

var exclude: Array = []

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * speed
	move_and_slide()
#	global_position = global_position.round()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var enemies: Array = G.get_closest_enemies(get_global_mouse_position())
		if enemies.size() > 0:
			var target: Node2D = enemies[0]
			var dot = DamageOverTime.new(30, 15, 0.5)
			target.health_component.add_child(dot)
