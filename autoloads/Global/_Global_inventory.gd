extends Node


const ITEM_DIR : String = "res://custom/items/"

## list of items the player has. remove and add items via the 'RemoveItem' and 'AddItem' actions.
@export var items : Array[Item]


func HasItem(name : String):

	for item in items:

		if item.name == name:

			return true

	return false


func GetItemQuantity(name : String):

	var q : int = 0

	for item in items:

		if item.name == name:

			q += 1
	
	return q


func AddItem(iname : String):

	var dir = DirAccess.open(ITEM_DIR)

	for item in dir.get_files():

		var x = load(ITEM_DIR + item)

		x.name = item.trim_suffix(".tres")

		if x.name != iname:

			pass

		else:

			items.push_back(x)
			
			print("added item ", x.name)

			return

	printerr("item not found, ", iname, ", didnt add")


func RemoveItem(iname : String):

	for item in items:

		if item.name == iname:

			items.pop_at(items.find(item))

			return

	printerr("item not found, ", iname, ", didnt remove")
