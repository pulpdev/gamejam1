extends Node


const DEFAULT_AMB_DB : float = -10.0


signal player_entered(player : Character)


@onready var dialogue := $dialogue

@onready var inventory := $inventory

@onready var vfx := $vfx


@export var variables : Dictionary = {

	"plot" : 0

}


func _ready():

	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
