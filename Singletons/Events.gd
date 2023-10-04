extends Node

# User Interface
signal ui_exp
signal ui_health
signal ui_damage_meter(name: String, amount: int, critical: bool)
signal ui_enemy_count(value: int)
signal ui_selected_upgrade(upgrade: Upgrade)
signal ui_clock(clock: Dictionary)

signal proc_on_hit(ability: String)
signal proc_on_crit(ability: String)

signal death

signal change_stat(stat: String, value: float)
