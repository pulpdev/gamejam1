extends EventAction


func _init():

	wait = true


func Execute():

	event.trigger.enabled = false

	for child in event.trigger.get_children():

		if not child is Event:

			child.queue_free()

	finished.emit()
