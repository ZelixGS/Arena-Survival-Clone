extends Button

@export var upgrade: Upgrade = Upgrade.new()

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var rich_text_label: RichTextLabel = %RichTextLabel

func _ready() -> void:
	texture_rect.texture = upgrade.icon
	label.text = upgrade.name
	rich_text_label.text = upgrade.get_tooltip()

func _on_pressed() -> void:
	Events.emit_signal("ui_selected_upgrade", upgrade)
