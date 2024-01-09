extends EventAction


func _init():
	
	wait = true


func Execute():

	if event.trigger is Door:

		event.trigger.locked = false

	finished.emit()
