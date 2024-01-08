extends EventAction


@export var item : String

@export_range(0,999999) var amount : int = 1


func _init():
	
	wait = true


func Execute():
	
	if Global.inventory.CachedItem(item):
		
		for i in range(0, amount):
			
			Global.inventory.AddItem(item)

	else:
		
		printerr("cannot give item, ", item, ", doesnt exist")

	finished.emit()
