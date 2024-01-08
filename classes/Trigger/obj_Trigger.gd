extends Marker3D

class_name Trigger


enum TYPES {NONE, ACTIVATE, TOUCH, AUTO}


signal triggered


var events : Array[Event]

@onready var area := $Area3D


var index : int = 0

var playerbody : Character


@export var type : TYPES


func _on_area_3d_body_entered(body):

	if body == get_tree().current_scene.player and type == TYPES.TOUCH:

		RunEvents()


func RunEvents():

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
