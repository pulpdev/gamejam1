extends EventAction

## what variable to set. this refers to a variable name in your Level's "Variables" property list.
@export var variable : String

## the operation to do to the variable
@export_enum("=", "+", "-") var operation : int = 0

## the value to set, add, or subtract from the variable
@export_range(0, 999999) var value : int = 0


func _init():

	wait = true


func Execute():

	if not Global.levelVariables.has(variable):

		printerr("variable not found, ", variable, ", cant set")

		finished.emit()

		return

	match operation:

		0:

			Global.levelVariables[variable] = value

		1:

			Global.levelVariables[variable] += value

		2:

			Global.levelVariables[variable] -= value

	finished.emit()
