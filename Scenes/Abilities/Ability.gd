extends Node
class_name Ability

@export var properties: AbilityProperties = AbilityProperties.new()
@export var projectile_resource: Resource

@onready var timer: Timer = $Timer
@onready var parent: Node2D = get_parent()

func activate() -> void:
#	var target: Node2D = G.get_closest_enemies(parent.global_position).front()
#	if is_instance_valid(target):
#		spawn_projectiles(parent.transform.looking_at(target.global_position))
	pass
	
func spawn_projectiles(target: Transform2D) -> void:
	for i in range(properties.projectiles):
		Create.projectile(projectile_resource, target, properties.duplicate())
		if properties.delay > 0:
			await get_tree().create_timer(properties.delay).timeout
	timer.start(properties.cooldown)
