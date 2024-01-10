extends EventAction

## what item to remove. must be the FILENAME of an 'item' in the 'custom/items' folder.
@export var item : String


func _init():

	wait = true


func Execute():

	Global.inventory.RemoveItem(item)

	finished.emit()
