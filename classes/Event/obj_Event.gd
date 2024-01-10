extends Node

class_name Event


signal started

signal finished


## list of condition types that must be passed to run
@export var conditions : Array[Condition]


var actions : Array[EventAction]

var index : int = 0

var trigger : Trigger


func _init():

	child_entered_tree.connect(_on_child_entered_tree)


func _ready():

	for c in get_children():

		actions.append(c)


func ConditionsMet():

	if conditions.size() == 0:

		return true

	for condition in conditions:

		if not condition.ConditionMet():

			return false

	return true


func Start():

	if not get_tree().current_scene.runningEvents.has(self):

		get_tree().current_scene.runningEvents.push_back(self)

	Run()

	started.emit()


func Run(startat : int = index):

	for i in range(startat, actions.size()):

		var action : EventAction = actions[i]

		if action.get_index() < actions.size() - 1:

			if action.wait:

				index = action.get_index() + 1

				action.finished.connect(Run)

				action.Run()

				return

			action.Run()

		elif action.get_index() == actions.size() - 1:

			if action.wait:

				action.finished.connect(OnEventFinished)

				action.Run()

				return

			action.Run()

			OnEventFinished()


func OnEventFinished():

	for action in actions:

		if action.is_connected("finished", Run):

			action.disconnect("finished", Run)

		if action.is_connected("finished", OnEventFinished):

			action.disconnect("finished", OnEventFinished)

	index = 0

	get_tree().current_scene.runningEvents.pop_at(get_tree().current_scene.runningEvents.find(self))

	finished.emit()


func _on_child_entered_tree(node):

	if node is EventAction:
		
		node.event = self
