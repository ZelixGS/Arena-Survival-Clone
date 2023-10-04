class_name Projectile extends HitboxComponent

signal expired

var properties: AbilityProperties
var stop_movement: bool = false

@onready var collision_shape_2d: CollisionShape2D = get_node_or_null("CollisionShape2D")
@onready var sprite_2d: Sprite2D = get_node_or_null("Sprite2D")
@onready var timer: Timer = get_node_or_null("Timer")

func _ready() -> void:
	setup()

func setup() -> void:
	calculate_damage()
	connect("strike", _on_strike)
#	scale *= properties.size
	if timer and properties.duration > 0:
		timer.start(properties.duration)

func calculate_damage():
	damage = properties.roll_damage()
	type = properties.type
	if properties.is_critical():
		damage *= floor(properties.critical_amplifier)
		crit_amp = properties.critical_amplifier
	else:
		crit_amp = 1.0
	
func _on_strike(node: Node2D):
	var crit: bool = true if crit_amp > 1 else false
	Create.floating_text(str(damage), node.get_global_transform(), crit)
	Events.emit_signal("ui_damage_meter", properties.ability_name, damage,  crit)
	Events.emit_signal("proc_on_hit")
	if crit:
		Events.emit_signal("proc_on_crit")
	calculate_damage()

func move_projectile(delta: float) -> void:
	position += (transform.x * properties.velocity) * delta

func despawn() -> void:
	emit_signal("expired")
	call_deferred("queue_free")

func fade_out() -> void:
	stop_movement = true
#	if collision_shape_2d:
#		collision_shape_2d.set_deferred("disabled", true)
	if sprite_2d:
		var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(sprite_2d, "modulate:a", 0, 0.2)
		tween.tween_callback(despawn)
	else:
		await get_tree().create_timer(0.2).timeout
		despawn()
