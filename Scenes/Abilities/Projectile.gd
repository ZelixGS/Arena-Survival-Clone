extends Node2D
class_name Projectile

var properties: AbilityProperties = AbilityProperties.new()
@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
	setup()

func setup() -> void:
	# Modify Size
	scale *= properties.size

	# Randomize Damage and apply to Hitbox.
	# First Index returns int of Damage
	# Second Index returns bool if Critical
	var damage = properties.roll_damage()
	hitbox_component.damage = damage[0]
	hitbox_component.critical = damage[1]

	if properties.duration > 0:
		var timer: Timer = Timer.new()
		timer.one_shot = true
		timer.connect("timeout", despawn)
		add_child(timer)
		timer.start(properties.duration)

func move_projectile(delta: float) -> void:
	position += (transform.x * properties.velocity) * delta

func despawn() -> void:
	call_deferred("queue_free")
