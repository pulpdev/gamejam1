extends Condition

class_name ConditionVariable

## what variable to check. see the list of variable names in your Level properties.
@export var variable : String

## how do we check the variable
@export_enum("==", "=/=", "<", ">", "<=", ">=") var operand : String = "=="

## value to compare it to
@export var value : int


func ConditionMet():

	if not Global.levelVariables.has(variable):

		printerr("variable not found, ", variable, ", can't compare")

		return
		
	match operand:
		
		"==":
			
			return Global.levelVariables[variable] == value
			
		"=/=":
			
			return not Global.levelVariables[variable] == value

		"<":
			
			return Global.levelVariables[variable] < value
		
		">":
			
			return Global.levelVariables[variable] > value
			
		"<=":
			
			return Global.levelVariables[variable] <= value

		">=":
			
			return Global.levelVariables[variable] >= value
