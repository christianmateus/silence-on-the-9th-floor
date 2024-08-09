extends CharacterBody3D

var SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Sensibilidade do movimento do mouse
@export var mouse_sensitivity: float = 0.3

# Limites de rotação vertical da câmera (em graus)
@export var min_pitch: float = -30.0
@export var max_pitch: float = 60.0

# Variáveis internas para controle da rotação
var yaw: float = 0.0
var pitch: float = 0.0

@onready var raycast: RayCast3D = $Head/RayCast

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("sprint") and is_on_floor():
		SPEED = 10.0
	else:
		SPEED = 5.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# CONTROLE DUALSHOCK/XBOX
	# Captura os movimentos do analógico direito
	#var look_x := Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	#var look_y := Input.get_action_strength("look_up") - Input.get_action_strength("look_down")
	#
	## Variáveis para inverter os controles
	#var invert_x := false
	#var invert_y := true
	#
	## Ajuste para inversão dos controles
	#if invert_x:
		#look_x = -look_x
	#if invert_y:
		#look_y = -look_y
		#
	## Calcula a nova rotação
	## Atualiza a rotação vertical com limitação
	#pitch -= look_y * mouse_sensitivity
	#pitch = clamp(pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))
	#rotation_degrees.x = pitch
#
	## Atualiza a rotação horizontal
	#rotate_y(deg_to_rad(-look_x * (mouse_sensitivity +2)))
	
	move_and_slide()

func _ready():
		# Trava o cursor do mouse no centro da tela
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Verifica se o evento é de movimento do mouse
	if event is InputEventMouseMotion:
		_update_rotation(event.relative)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _update_rotation(mouse_delta):
	# Atualiza o yaw (rotação horizontal) com base no movimento do mouse
	yaw -= mouse_delta.x * mouse_sensitivity

	# Atualiza o pitch (rotação vertical), limitando entre min_pitch e max_pitch
	pitch -= mouse_delta.y * mouse_sensitivity
	pitch = clamp(pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

	# Define a rotação da câmera
	rotation_degrees = Vector3(rad_to_deg(pitch), rad_to_deg(yaw), 0)

#func check_for_interactables():
	#if raycast.is_colliding():
		#var collider = raycast.get_collider()
		#if collider and collider.has_method("on_interact"):
			#interact_label.text = collider.interaction_text
			#interact_label.visible = true
			#if Input.is_action_just_pressed(interact_key):
				#collider.on_interact()
		#else:
			#interact_label.visible = false
	#else:
		#interact_label.visible = false
