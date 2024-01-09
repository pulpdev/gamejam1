extends Condition

class_name ConditionVariable


@export var variable : String

@export_enum("==", "=/=", "<", ">", "<=", ">=") var operand : String = "=="

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
