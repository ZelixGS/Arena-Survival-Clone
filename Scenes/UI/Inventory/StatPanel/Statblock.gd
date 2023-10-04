extends HBoxContainer

@onready var stat_name: Label = $StatName
@onready var stat_amount: Label = $StatAmount

var _name: String = "null"

func _ready() -> void:
	create()

func create() -> void:
	set_name.call_deferred(_name)
	update()

func update() -> void:
	stat_name.text = _name.replace("_", " ").replace("critical", "crit").capitalize()
	var value = Stats.get_stat(_name)
	if value is float:
		stat_amount.text = G.to_percent(value)
	else:
		stat_amount.text = str(value)
