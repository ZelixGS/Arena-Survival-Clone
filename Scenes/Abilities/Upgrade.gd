class_name Upgrade extends Resource

enum Type { PASSIVE, ACTIVE, ABILITY }
enum Calculation { ADDITIVE, MULTIPLICATIVE }

@export var name: String = ""
@export var icon: Texture
@export_multiline var desc: String = "Increases [$s] by [$v]."
@export var type: Type = Type.PASSIVE
@export_category("Ability")
@export var ability: Ability

@export_category("Passive")
@export_enum("damage","velocity","cooldown","duration","size","knockback","critical_chance","critical_amp","projctiles","chain","penetration","health","armor","shield","regeneration","speed","magnet","experience","avarice","serendipity","spawn_base","spawn_rate","spawn_limit") var stat: String = "damage"
@export var amount: float = 1
@export var calculation: Calculation = Calculation.MULTIPLICATIVE

func get_tooltip() -> String:
	var mod_desc: String  = desc.replace("$s", str(stat).capitalize())
	print(mod_desc)
	if calculation == Calculation.MULTIPLICATIVE:
		var perc: String = "%.2f%%" % ((amount-1)*100)
		mod_desc = mod_desc.replace("$v", perc)
		print(mod_desc)
	else:
		mod_desc = mod_desc.replace("$v", str(floor(amount)))
		print(mod_desc)
	return mod_desc
