extends Node

const TIME_PERIOD: float = 1 # 1000ms

var time: float = 0
var normal_time: float = 0
var rate: float = 1.0
var seconds: int = 0

func _process(delta: float) -> void:
	normal_time += delta
	time += delta * rate
	if time > TIME_PERIOD:
		seconds += 1
		Events.emit_signal("ui_clock", _seconds_to_clock())
		time = 0
		
func _seconds_to_clock() -> Dictionary:
	var _minutes: int = floor(seconds / 60.0)
	var _seconds: int = seconds - (_minutes * 60)
	return {"minutes": _minutes, "seconds": _seconds}
