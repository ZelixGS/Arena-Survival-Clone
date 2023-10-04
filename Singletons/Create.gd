extends Node

@onready var floating_text_scene: PackedScene = preload("res://Scenes/UI/FloatingText/FloatingText.tscn")

func add_to_node(target: Node, obj: Node) -> void:
	target.call_deferred("add_child", obj)

func add_to_world(obj: Node) -> void:
	G.get_stage().call_deferred("add_child", obj)

func node(res: Resource, spawn: Transform2D) -> void:
	var _node: Node2D = res.instantiate()
	_node.global_position = spawn.get_origin()
	add_to_world(_node)

func projectile(res: Resource, spawn: Transform2D, properties: AbilityProperties) -> void:
	var p: Projectile = res.instantiate()
	p.properties = properties
	p.position = spawn.get_origin()
	p.rotation = spawn.get_rotation()
	add_to_world(p)

func damage_over_time(res: Resource, target: CharacterBody2D, args: Dictionary = {}):
	var dot = res.instantiate()
	dot.args = args
	dot.health_component = target.get_node_or_null("health_component")
	target.add_child(dot)

func particle(res: Resource, target) -> void:
	var p = res.instantiate()
	if target is Transform2D:
		p.position = target.get_origin()
		p.rotation = target.get_rotation()
		G.get_stage().add_child(p)
	if target is Node2D:
		target.add_child(p)
	
func floating_text(value: String, spawn: Transform2D, critical: bool = false, duration: float = 0.2, travel: Vector2 = Vector2.UP, spread: float = 45.0) -> void:
	var text: FloatingText = floating_text_scene.instantiate()
	text.position = spawn.get_origin()
#	text.position += travel * 8 # Offset by 8px
	text.rotation = 0
	G.get_stage().add_child(text)
	text.create(value, duration, travel, spread, critical)
