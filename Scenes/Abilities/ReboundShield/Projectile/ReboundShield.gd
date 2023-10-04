extends Projectile

var search_radius: float = 450
var target: Node2D
var exclude: Array = []
var strikes: int = 0
var returning_to_player: bool = false

@onready var player: Player = G.get_player()

func _ready() -> void:
	setup()
	connect("strike", on_struck)
	target = get_target()

func _physics_process(delta: float) -> void:
	if stop_movement:
		return
	if is_instance_valid(target):
		look_at(target.global_position)
		if returning_to_player and global_position.distance_squared_to(target.global_position) < 16:
			fade_out()
	else:
		return_to_player()
	move_projectile(delta)

func on_struck(node: Node2D) -> void:
	if returning_to_player:
		return
	
	if node is Entity and not exclude.has(node):
		strikes += 1
		exclude.append(node)
		target = null

	if strikes > properties.bounces:
		return_to_player()

	if not returning_to_player:
		target = get_target()

func get_target() -> Node2D:
	var possible = G.get_closest_enemies(global_position, search_radius, exclude)
	if possible.size() > 0:
		return possible.front()
	else:
		returning_to_player = true
		properties.velocity *= 2
		return player

func return_to_player() -> void:
	returning_to_player = true
#	properties.velocity *= 2
	target = player
