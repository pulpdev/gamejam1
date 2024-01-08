extends Node


const ITEM_DIR : String = "res://custom/items/"

@export var cache : Array[Item]

@export var items : Array[Item]


func _init():

	var dir = DirAccess.open(ITEM_DIR)

	for item in dir.get_files():

		var x = load(ITEM_DIR + item)

		x.name = item.trim_suffix(".tres")

		cache.append(x)

	AddItem("key_gold")


func CachedItem(name : String):

	for item in cache:

		if item.name == name:

			return true

	return false


func HasItem(name : String):

	for item in items:

		if item.name == name:

			return true

	return false


func GetItemQuantity(name : String):
	
	var q : int
	
	for item in items:
		
		if item.name == name:
			
			q += 1

	return q


func AddItem(name : String):

	for item in cache:
		
		if item.name == name:
			
			var new = item.duplicate()
			
			items.push_back(new)

			return

	printerr("item not found", name)
