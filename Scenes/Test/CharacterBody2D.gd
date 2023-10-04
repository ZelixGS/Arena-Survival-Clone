extends CharacterBody2D

@onready var player: Player = G.get_player()
var speed = 3
var a: = 400
var time: float = 0.0

func _ready() -> void:
#	var tween: Tween = create_tween()
#	tween.set_trans(Tween.TRANS_LINEAR)
#	tween.tween_property(self, "a", 0, 8.0)
#	tween.play()'
	pass
	
func _process(delta: float) -> void:
	time += delta
#	position = orbit(player.global_position)
	velocity = spiral(45)
	move_and_slide()

func spiral(a: float) -> Vector2:
	var c: float = cos(deg_to_rad(a))
	var s: float = sin(deg_to_rad(a))
	var x: float = (global_position.x - player.global_position.x)
	var y: float = (global_position.y - player.global_position.y)
	var new_x: float = c * x - s * y + global_position.x
	var new_y: float = s * x + c * y + global_position.y
	return Vector2(new_x, new_y) - global_position

func orbit(center: Vector2, radius: float = 150) -> Vector2:
	var s: float = sin(Clock.normal_time * speed) * max(radius - time, 0)
	var c: float = cos(Clock.normal_time * speed) * max(radius - time, 0)
	return Vector2(s, c) + center
