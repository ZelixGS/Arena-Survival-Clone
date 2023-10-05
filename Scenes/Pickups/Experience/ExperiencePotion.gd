class_name ExperienceDrop extends Node2D

@export var amount: int = 1
var green: Rect2 = Rect2(96, 144, 16, 16)
var red: Rect2 = Rect2(112, 144, 16, 16)

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	if amount > 2 and amount < 9:
		sprite_2d.region_rect = green
	if amount > 9:
		sprite_2d.region_rect = red

func _on_area_2d_area_entered(area: Area2D) -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position", area.owner.global_position, 0.05)
	tween.tween_callback(despawn)
	
func despawn() -> void:
	Experience.emit_signal("exp_gain", amount * Stats.get_experience())
	call_deferred("queue_free")
