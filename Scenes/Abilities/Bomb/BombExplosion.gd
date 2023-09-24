extends Node2D

var dot: Resource = preload("res://scenes/Abilities/Bomb/Sharpnel.tscn")
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var timer: Timer = $Timer

@export var damage: int = 12

func _ready() -> void:
	hitbox_component.damage = damage
	await get_tree().physics_frame
	timer.start(0.2)

func _on_timer_timeout() -> void:
	for i in hitbox_component.get_overlapping_areas():
		if i.owner is CharacterBody2D:
			Create.damage_over_time(dot, i.owner)
	
	call_deferred("queue_free")
