extends CharacterBody3D

class_name Character


@onready var pivot_camera := $CameraPivot

@onready var pivot_model := $ModelPivot


@export var speed : float = 3.0

@export var jumpheight : float = 4.0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var flashlighting : bool = false:

	set(b):
		
		flashlighting = b
		
		if not canFlashlight:
			
			flashlighting = false
		
			pivot_camera.flashlight.light_color = Color(0,0,0,0)
		
			return
		
		if flashlighting:
			
			pivot_camera.flashlight.light_color = Color(1,1,1,1)
			
		else:
			
			pivot_camera.flashlight.light_color = Color(0,0,0,0)
			
			
@export var enableInput : bool = true

@export var canFlashlight : bool = true


var jumped : bool :

	get:

		return Input.is_action_just_pressed("action_jump") and is_on_floor()


var vector_input : Vector2:

	get:

		return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


func _ready():
	
	Global.player_entered.emit(self)

	flashlighting = false


func _unhandled_input(event):

	if Input.is_action_just_released("action_flashlight"):

		flashlighting = not flashlighting


func _physics_process(delta):

	if enableInput:

		move(Vector3(vector_input.x, vector_input.y, 0), delta)

	pivot_model.rotation.y = pivot_camera.rotation.y


func _process(delta):

	transform.basis = Basis.from_euler(Vector3(0.0 , pivot_camera.vector_view.y, 0.0 ))


func move(dir : Vector3, delta):

	var d = (transform.basis * Vector3(dir.x, 0, dir.y)).normalized()

	var slide : float

	if d:

		velocity.x = lerp(velocity.x, d.x * speed, 0.1)

		velocity.z = lerp(velocity.z, d.z * speed, 0.1)

	else:

		if is_on_floor():

			velocity.x = lerp(velocity.x, 0.0, 0.5)

			velocity.z = lerp(velocity.z, 0.0, 0.5)


	if not is_on_floor():

		velocity.y -= gravity * delta

	if jumped:

		velocity.y = jumpheight

	move_and_slide()
