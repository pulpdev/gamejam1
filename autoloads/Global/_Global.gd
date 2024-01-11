extends Node


signal player_entered(player : Character)

signal level_ready


@onready var dialogue := $dialogue

@onready var inventory := $inventory

@onready var vfx := $vfx

@onready var scene := $scene

@onready var sfx = $sfx


var levelVariables : Dictionary :

	get:

		if get_tree().current_scene:

			return get_tree().current_scene.variables

		return {}


## list of global game variables. use these to control game progression with the 'ConditionVariable' resource.
@export var variables : Dictionary = {

	"plot" : 0

}


func _ready():

	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)



