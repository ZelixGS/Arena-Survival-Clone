extends HBoxContainer

@onready var label: Label = $Panel/Label
@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	Events.connect("ui_exp", update)

func update(level: int, current: int, previous: int, next: int) -> void:
	update_label(level)
	update_bar(current, previous, next)
	
func update_label(level: int) -> void:
	label.text = str(level)

func update_bar(current: int, previous: int, next: int) -> void:
#	print("Current[%s], Previous[%s], Next[%s]" % [current, previous, next])
	progress_bar.min_value = previous
	progress_bar.max_value = next
	progress_bar.value = current
