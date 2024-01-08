extends EventAction


@export var variable : String

@export_enum("=", "+", "-") var operation : int = 0

@export_range(0, 999999) var value : int = 0


func _init():

	wait = true


func Execute():
	
	if not Global.variables.has(variable):

		printerr("variable not found, ", variable, ", cant set")
		
		finished.emit()
		
		return
		
	match operation:
		
		0:
			
			Global.variables[variable] = value
			
		1:
			
			Global.variables[variable] += value
			
		2:
			
			Global.variables[variable] -= value
			
	finished.emit()
