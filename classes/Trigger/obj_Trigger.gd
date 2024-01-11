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

## set how the trigger will be triggered
@export var type : TYPES


func _init():

	child_entered_tree.connect(_on_child_entered_tree)


func _ready():

	if type == TYPES.AUTO:

		Global.level_ready.connect(RunEvents)

	area.body_entered.connect(_on_area_3d_body_entered)


func _on_area_3d_body_entered(body):

	if body == get_tree().current_scene.player and type == TYPES.TOUCH:

		RunEvents()


func RunEvents():

	if not enabled:

		return

	if self is Door and not self.locked and not self.runEventsIfUnlocked:

		return

	for event in events:

		if get_tree().current_scene.runningEvents.has(event):

			return

	for event in events:

		if event.ConditionsMet():

			event.Start()

			return


func _on_child_entered_tree(node):

	if node is Event:

		events.append(node)

		node.trigger = self
