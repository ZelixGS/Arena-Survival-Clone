extends Projectile

var search_radius: float = 450
var target: Node2D
var exclude: Array = []
var strikes: int = 0
var returning_to_player: bool = false
var stop_movement: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var player: Player = G.get_player()

func _ready() -> void:
	setup()
	target = get_target()

func _physics_process(delta: float) -> void:
	if stop_movement:
		return
	if is_instance_valid(target):
		look_at(target.global_position)
		if returning_to_player and global_position.distance_squared_to(target.global_position) < 16:
			despawn()
	else:
		return_to_player()
	move_projectile(delta)


func _on_hitbox_component_struck(area: Area2D) -> void:
	if returning_to_player:
		return
	
	if area.owner is Entity and not exclude.has(area):
		strikes += 1
		exclude.append(area.owner)
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

func despawn() -> void:
	stop_movement = true
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sprite_2d, "modulate:a", 0, 0.2)
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	call_deferred("queue_free")
