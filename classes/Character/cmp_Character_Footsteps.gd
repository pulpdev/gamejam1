extends Node


var jumpLandSound = load("res://assets/sounds/land_1.wav")

var jumpSound = load("res://assets/sounds/jump_1.wav")

var stepSounds : Array = [

	load("res://assets/sounds/snake_step_1.wav"),

	load("res://assets/sounds/snake_step_2.wav")

]


var currentSound : int

var playJumpLandSound : bool


@onready var stepPlayer : AudioStreamPlayer3D = $StepSound

@onready var jumpPlayer : AudioStreamPlayer3D = $JumpSound

@onready var landPlayer : AudioStreamPlayer3D = $LandSound

@onready var timer : Timer = $Timer


func _on_timer_timeout():

	stepPlayer.stream = stepSounds[currentSound]

	stepPlayer.pitch_scale = randf_range(0.85, 0.95)

	stepPlayer.play()

	if currentSound == 0:
		
		currentSound = 1
		
	elif currentSound == 1:
		
		currentSound = 0
