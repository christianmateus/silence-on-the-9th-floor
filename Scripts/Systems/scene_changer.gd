extends CanvasLayer

signal scene_changed()

@onready var anim: AnimationPlayer = $Anim
@onready var black: ColorRect = $Control/Black

func change_scene(path, delay = 0.5):
	await get_tree().create_timer(delay).timeout
	anim.play("fade")
	
	await anim.animation_finished
	get_tree().change_scene_to_file(path)
	
	anim.play_backwards("fade")
	await anim.animation_finished
	emit_signal("scene_changed")
