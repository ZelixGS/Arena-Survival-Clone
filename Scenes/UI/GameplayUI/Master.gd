extends Control

@onready var pause_menu: Control = $PauseMenu
@onready var game_ui: Control = $GameUI
@onready var death: Control = $Death

var dead: bool = false

func _ready() -> void:
	Events.connect("death", on_death)
	pause_menu.visible = false
	death.visible = false
	game_ui.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu") and not dead:
		pause_game()

func pause_game() -> void:
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = !get_tree().paused

func _on_continue_pressed() -> void:
	pause_game()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()

func on_death() -> void:
	dead = true
	pause_menu.visible = false
	game_ui.visible = false
	death.visible = true
