extends HBoxContainer

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	Events.connect("ui_health", update_health)

func update_health(current_value, max_value) -> void:
	progress_bar.value = current_value
	progress_bar.max_value = max_value
