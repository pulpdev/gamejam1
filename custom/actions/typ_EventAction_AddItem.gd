extends EventAction

## what item to give. must be the FILENAME of an 'item' in the 'custom/items' folder.
@export var item : String


var player : AudioStreamPlayer

var sound = load("res://assets/sounds/pickup_1.wav")


func _init():

	wait = true


func Execute():

	Global.inventory.AddItem(item)

	player = AudioStreamPlayer.new()

	add_child(player)

	player.stream = sound

	player.finished.connect(

		func():

			player.queue_free()

	)

	player.play()

	finished.emit()
