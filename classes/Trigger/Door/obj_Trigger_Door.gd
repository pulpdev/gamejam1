extends Trigger

class_name Door


enum OPEN_TYPES {SWING, PUSH}


## door starts out locked and must be unlocked via the 'UnlockDoor' action
@export var locked : bool

## can you close door after opening it
@export var canClose : bool

## how the door will move around, like a normal door or drawer, slinding door, ect
@export var openType: OPEN_TYPES


## false and hinge on the left, door swings away.
## true and hinge on the left, door swings towards you.
## false and hinge on the right, door swings away.
## true and hinge on the right, door swings towards you.
@export var reverseOpen : bool

## will door still process its events if unlocked
@export var runEventsIfUnlocked : bool = false


var opened : bool :

	set(x):

		opened = x
		
		openPlayer.pitch_scale = randf_range(0.98, 1.02)

		openPlayer.play()

var openSound1 = load("res://assets/sounds/dooropen_1.wav")

var openSound2 = load("res://assets/sounds/dooropen_2.wav")

var lockedSound = load("res://assets/sounds/doorlocked_1.wav")

var openPlayer : AudioStreamPlayer3D

var lockedPlayer : AudioStreamPlayer3D


@onready var initPosition : Vector3 = position

@onready var endPosition : Vector3 :
	
	get:
		
		if reverseOpen:
			
			return initPosition - transform.basis.x / 3
			
		return initPosition + transform.basis.x / 3


@onready var initRotation : Vector3 = rotation

@onready var endRotation : Vector3 :
	
	get:
		
		if reverseOpen:
			
			return initRotation + Vector3(0,deg_to_rad(90),0)
			
		return initRotation - Vector3(0,deg_to_rad(90),0)


func _ready():
	
	if has_node("direction"):

		$direction.visible = false

	if type == TYPES.AUTO:

		Global.level_ready.connect(RunEvents)

	if not area == null:

		area.body_entered.connect(_on_area_3d_body_entered)

	openPlayer = AudioStreamPlayer3D.new()

	lockedPlayer = AudioStreamPlayer3D.new()
	
	match openType:
		
		OPEN_TYPES.SWING:

			openPlayer.stream = openSound1
			
		OPEN_TYPES.PUSH:

			openPlayer.stream = openSound2

	openPlayer.max_polyphony = 8

	lockedPlayer.stream = lockedSound

	lockedPlayer.max_polyphony = 8

	add_child(lockedPlayer)

	add_child(openPlayer)


func Open():

	if locked:

		lockedPlayer.pitch_scale = randf_range(0.98, 1.02)

		lockedPlayer.play()

		return

	match  openType:
		
		OPEN_TYPES.SWING:

			if not opened:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"rotation",
					
					endRotation,
					
					1
				).set_trans(Tween.TRANS_QUAD)
				
				opened = true
				
			else:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"rotation",
					
					initRotation,
					
					1
				).set_trans(Tween.TRANS_QUAD)
		
				opened = false
				
		OPEN_TYPES.PUSH:
			
			if not opened:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"position",
					
					endPosition,
					
					0.5
				).set_trans(Tween.TRANS_SPRING)
				
				opened = true
				
			else:
				
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"position",
					
					initPosition,
					
					0.5
				).set_trans(Tween.TRANS_SPRING)
		
				opened = false
