extends Marker3D

class_name Trigger


enum TYPES {
	
	## activate when player presses 'e' or 'enter'
	ACTIVATE, 

	## activate when player touches it. may not work on doors.
	TOUCH, 

	## triggers once when level is ready
	AUTO, 

	## can only activate via the 'ActivateTrigger' action
	MANUAL}


signal triggered


var events : Array[Event]

@onready var area : Area3D = $Area3D


var index : int = 0

var playerbody : Character

var enabled : bool = true : 
	
	set(d):
		
		enabled = d
		
		visible = enabled
		
var triggeredOnce : bool

## set how the trigger will be triggered
@export var type : TYPES

## will trigger only once then never again
@export var triggerOnce : bool


func _init():

	child_entered_tree.connect(_on_child_entered_tree)


func _ready():
	
	$direction.visible = false

	if type == TYPES.AUTO:

		Global.level_ready.connect(RunEvents)

	area.body_entered.connect(_on_area_3d_body_entered)


func _on_area_3d_body_entered(body):

	if body is Character and type == TYPES.TOUCH:

		RunEvents()

		if self is Door:

			call("Open")


func RunEvents():

	if not enabled:

		return

	if triggerOnce and triggeredOnce:

		return

	for event in events:

		if get_tree().current_scene.runningEvents.has(event):
			print(567567)
			return

	if self is Door:

		call("Open")

	for event in events:

		if event.ConditionsMet():

			triggeredOnce = true

			event.Start()

			return


func _on_child_entered_tree(node):

	if node is Event:

		events.append(node)

		node.trigger = self
