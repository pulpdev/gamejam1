extends Node


@onready var dialogue := $dialogue

@onready var inventory := $inventory


@export var variables : Dictionary = {

	"plot" : 0

}


func _ready():

	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
