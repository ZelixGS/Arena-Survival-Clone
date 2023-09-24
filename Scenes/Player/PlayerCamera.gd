extends Camera2D

@onready var player: Player = G.get_player()

func _physics_process(_delta: float) -> void:
	if is_instance_valid(player):
		global_position = player.global_position.snapped(Vector2(1, 1))
