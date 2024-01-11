extends CharacterBody3D

class_name Character

## self explanitory
@export var walkSpeed = 3

var crouchSpeed = 1


@onready var pivot_camera := $CameraPivot

@onready var pivot_model := $ModelPivot

@onready var footsteps := $Footsteps


var speed : float = 3.0

## self explanitory
@export var jumpheight : float = 4.0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") + 3

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


## enable or disable player movement
@export var enableInput : bool = true

## enable or disable the flashlight
@export var canFlashlight : bool = true


var jumped : bool :

	get:

		return Input.is_action_just_pressed("action_jump") and is_on_floor()


var vector_input : Vector2:

	get:

		return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
		
var crouching : bool :
	
	set(c):
		
		crouching = c
		
		if crouching:
			
			var t = create_tween()
			
			t.tween_property(
				
				pivot_camera,
				
				"position",
				
				pivot_camera.init_position - Vector3(0,0.75,0),
				
				0.1
			)
			
			footsteps.timer.wait_time = 1.25 / speed
			
		else:
			
			var t = create_tween()
			
			t.tween_property(
				
				pivot_camera,
				
				"position",
				
				pivot_camera.init_position,
				
				0.1
			)
			footsteps.timer.wait_time = 1.25 / speed

func _ready():
	
	pivot_model.visible = false

	footsteps.timer.wait_time = 1.25 / speed

	Global.player_entered.emit(self)

	flashlighting = false

	pivot_camera.vector_view.y = global_rotation.y


func _unhandled_input(event):

	if Input.is_action_just_released("action_flashlight"):

		flashlighting = not flashlighting
		
		if canFlashlight:
			
			$FlashlightSound.play()


func _physics_process(delta):

	if enableInput:

		move(Vector3(vector_input.x, vector_input.y, 0), delta)

	else:

		move(Vector3.ZERO, delta)

	pivot_model.rotation.y = pivot_camera.rotation.y

	if not vector_input == Vector2.ZERO and enableInput and is_on_floor():

		if footsteps.timer.is_stopped():

			footsteps.timer.start()

	else:

		footsteps.timer.stop()

	if is_on_floor() and footsteps.playJumpLandSound:

		footsteps.landPlayer.play()

		footsteps.playJumpLandSound = false
		
		
	if Input.is_action_pressed("action_crouch"):

		crouching = true
		
		speed = crouchSpeed
		
	else:
		
		crouching = false
		
		speed = walkSpeed


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

		footsteps.playJumpLandSound = true

		footsteps.jumpPlayer.play()

		velocity.y = jumpheight

	move_and_slide()
