extends EventAction


func _init():

	wait = true


func Execute():

	event.trigger.queue_free()

	finished.emit()
