extends Node

func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")

func get_player_position() -> Vector2:
	var player: Player = get_player()
	if is_instance_valid(player):
		return player.global_position
	return Vector2.ZERO

func get_stage() -> Node2D:
	return get_tree().get_first_node_in_group("stage")

func get_closest_enemies(pos: Vector2, max_range: float = 0, exclude: Array = []) -> Array:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy")
	if max_range > 0:
		enemies = enemies.filter(func(enemy: Node2D):
			return enemy.global_position.distance_squared_to(pos) < pow(max_range, 2)
		)

	if exclude.size() > 0:
		enemies = enemies.filter(func(enemy: Node2D):
			return not exclude.has(enemy)
	)

	if enemies.size() == 0:
		return []
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance: float = a.global_position.distance_squared_to(pos)
		var b_distance: float = b.global_position.distance_squared_to(pos)
		return a_distance < b_distance
	)

	return enemies

func index_exists(array: Array, index: int) -> bool:
	return index >= 0 and index < array.size() 

func get_snapped_angle(value: int, steps:int, pos: Vector2, radius: float) -> Vector2:
	var snap = 2 * PI / steps
	return pos + Vector2(radius, 0).rotated(snap * value)

func calculate_damage(value: int) -> int:
	return floor(randf_range(value * 0.8, value * 1.2))

func random_from_table(input: Array) -> Variant:
	var total_weight: float = 0
	var cumulative: Array = []

	for i in input.size():
		total_weight += input[i][1]
		cumulative.append([input[i][0], total_weight])

	var chance = randf_range(0, total_weight)
	for i in cumulative:
		if chance < i[1]:
			return i[0]
	return null