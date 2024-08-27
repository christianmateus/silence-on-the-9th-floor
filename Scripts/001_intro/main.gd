extends Node3D

@onready var car_cam: Camera3D = $intro_road/Car/Car_cam

# Tamanho da Viewport de baixa resolução (por exemplo, 320x240)
@export var camera_path : NodePath
@export var low_res_width = 320
@export var low_res_height = 240

var sub_viewport: SubViewport
var sprite_3d: Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Criar e configurar o SubViewport
	sub_viewport = SubViewport.new()
	sub_viewport.size = Vector2(low_res_width, low_res_height)
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	sub_viewport.transparent_bg = true
	add_child(sub_viewport)

	# Criar um Sprite3D para exibir a textura do SubViewport
	sprite_3d = Sprite3D.new()
	sprite_3d.texture = sub_viewport.get_texture()
	sprite_3d.scale = Vector3(10, 10, 10)  # Ajustar escala conforme necessário
	add_child(sprite_3d)

	# Posicionar o Sprite3D em frente à câmera
	sprite_3d.global_transform.origin = car_cam.global_transform.origin + car_cam.global_transform.basis.z * -1
	sprite_3d.look_at(car_cam.global_transform.origin, Vector3.UP)
	#get_window().content_scale_size = Vector2i(1920, 1080)
	Dialogic.start('timeline')
	get_viewport().set_input_as_handled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
