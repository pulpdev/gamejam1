extends Node


## name of the level file in 'custom/levels/'
@export var startingLevel : String


func _ready():

	Global.scene.ChangeLevel(startingLevel)
