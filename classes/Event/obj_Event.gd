extends Node

class_name Event


signal started

signal finished


@export var conditions : Array[Condition]

@export var wait : bool


var actions : Array[EventAction]

var index : int = 0

var trigger : Trigger


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

	if not wait:

		finished.emit()


func Run(startat : int = index):

	for i in range(startat, actions.size()):

		var action : EventAction = actions[i]

		if action.get_index() < actions.size() - 1:

			if action.wait:

				index += 1

				if not action.finished.is_connected(Run):

					action.finished.connect(Run)

				action.Run()

				return

			action.Run()

		elif action.get_index() == actions.size() - 1:

			if action.wait:

				if not action.finished.is_connected(OnEventFinished):

					action.finished.connect(OnEventFinished)

				action.Run()

				return

			else:

				action.Run()

				OnEventFinished()


func OnEventFinished():

	for action in actions:

		if action.finished.is_connected(Run):

			action.finished.disconnect(Run)

		if action.finished.is_connected(OnEventFinished):

			action.finished.disconnect(OnEventFinished)

	index = 0

	get_tree().current_scene.runningEvents.pop_at(get_tree().current_scene.runningEvents.find(self))

	if wait:

		finished.emit()


func _on_child_entered_tree(node):

	if node is EventAction:
		
		node.event = self
