extends GPUParticles2D
class_name ParticleFX

func _ready() -> void:
	emitting = true
	if one_shot:
		await get_tree().create_timer(lifetime).timeout
		queue_free()
