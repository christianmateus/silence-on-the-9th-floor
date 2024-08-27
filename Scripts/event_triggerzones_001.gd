extends Node

@onready var event_2: Area3D = $Event2
@onready var camera_2: Camera3D = $"../Node/Camera2"
@onready var camera_3: Camera3D = $"../Node/Camera3"
@onready var camera2_anim: AnimationPlayer = $"../Node/Camera2/Anim"
@onready var anim_car_tires: AnimationPlayer = $"../intro_road/Car/Anim_car_tires"
@onready var car_cam: Camera3D = $"../intro_road/Car/Car_cam"
@onready var camera3_anim: AnimationPlayer = $"../Node/Camera3/Anim"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_event_1_area_entered(area: Area3D) -> void:
	if area.get_parent_node_3d().name == "Car":
		anim_car_tires.stop()
		SceneChanger.change_scene("")

func _on_event_2_area_entered(area: Area3D) -> void:
	if area.get_parent_node_3d().name == "Car":
		camera_2.current = true;
		camera2_anim.play("move")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move":
		car_cam.current = true;


func _on_event_3_area_entered(area: Area3D) -> void:
	if area.get_parent_node_3d().name == "Car":
		camera_3.current = true;
		camera3_anim.play("move")
