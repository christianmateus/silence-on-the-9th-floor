extends Node3D

@onready var car_cam: Camera3D = $intro_road/Car/Car_cam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	car_cam.size = 1
	pass
	#get_window().content_scale_size = Vector2i(1920, 1080)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('timeline')
		get_viewport().set_input_as_handled()
