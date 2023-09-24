extends Panel

@onready var fps: Label = %FPS
@onready var ram: Label = %RAM
@onready var mob: Label = %MOB

func _ready() -> void:
	Events.connect("ui_enemy_count", update_counter)

func _process(_delta: float) -> void:
	fps.text = str("FPS: %d" % Engine.get_frames_per_second())
	ram.text = str("RAM: %s" % String.humanize_size(OS.get_static_memory_usage()))

func update_counter(value: int) -> void:
	mob.text = str("MOB: %s" % value)
