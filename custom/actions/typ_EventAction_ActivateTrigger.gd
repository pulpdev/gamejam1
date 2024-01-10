extends EventAction

## designed to trigger 'Manual' triggers, but still useful
@export var target : Trigger


func _init():

	wait = true


func Execute():

	target.RunEvents()

	finished.emit()
