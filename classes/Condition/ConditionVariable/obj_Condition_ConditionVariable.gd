extends Condition

class_name ConditionVariable

## what variable to check. see the list of variable names in 'autoloads/Global/_Global.gd'
@export var variable : String

## how do we check the variable
@export_enum("==", "=/=", "<", ">", "<=", ">=") var operand : String = "=="

## value to compare it to
@export var value : int


func ConditionMet():

	if not Global.variables.has(variable):

		printerr("variable not found, ", variable, ", can't compare")

		return
		
	match operand:
		
		"==":
			
			return Global.variables[variable] == value
			
		"=/=":
			
			return not Global.variables[variable] == value

		"<":
			
			return Global.variables[variable] < value
		
		">":
			
			return Global.variables[variable] > value
			
		"<=":
			
			return Global.variables[variable] <= value

		">=":
			
			return Global.variables[variable] >= value
