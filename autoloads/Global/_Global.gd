extends Node


signal player_entered(player : Character)


@onready var dialogue := $dialogue

@onready var inventory := $inventory

@onready var vfx := $vfx


@export var variables : Dictionary = {

	"plot" : 0

}


func _ready():

	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
