extends EventAction


@export var door : Door

@export var closeDoor : bool = true


func _init():

	wait = true


func Execute():

	if door.opened:

		door.Open()

	door.locked = true

	finished.emit()
