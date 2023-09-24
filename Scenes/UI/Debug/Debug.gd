extends Control

@onready var god: CheckBox = %God
@onready var damage: SpinBox = %Damage
@onready var experience: SpinBox = %Experience
@onready var spawn_cap: SpinBox = %SpawnCap
@onready var per_wave: SpinBox = %PerWave

func _on_god_toggled(button_pressed: bool) -> void:
	Events.emit_signal("change_stat", "god", button_pressed)
	god.release_focus()
	
func _on_damage_value_changed(value: float) -> void:
	Events.emit_signal("change_stat", "damage", value)
	damage.release_focus()

func _on_experience_value_changed(value: float) -> void:
	Events.emit_signal("change_stat", "experience_rate", value)
	experience.release_focus()

func _on_spawn_cap_value_changed(value: float) -> void:
	Events.emit_signal("change_stat", "spawn_limit", value)
	spawn_cap.release_focus()
	
func _on_per_wave_value_changed(value: float) -> void:
	Events.emit_signal("change_stat", "spawn_rate", value)
	per_wave.release_focus()
