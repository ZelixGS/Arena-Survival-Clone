extends Label

func _ready() -> void:
	Events.connect("ui_clock", update_clock)

func update_clock(time: Dictionary) -> void:
	text = "%02d: %02d" % [time["minutes"], time["seconds"]]
