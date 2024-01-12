extends EventAction

## designed to trigger 'Manual' triggers, but still useful
@export var target : Trigger


func _init():

	wait = true


func Execute():

	if not target:

		printerr("target field is empty for ActivateTrigger")

		finished.emit()

		return

	target.RunEvents()

	finished.emit()
