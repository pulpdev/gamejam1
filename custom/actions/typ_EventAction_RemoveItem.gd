extends EventAction


@export var item : String


func _init():

	wait = true


func Execute():

	Global.inventory.RemoveItem(item)

	finished.emit()
