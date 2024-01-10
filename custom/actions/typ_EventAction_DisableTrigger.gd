extends EventAction


func _init():

	wait = true


func Execute():

	event.trigger.enabled = false

	finished.emit()
