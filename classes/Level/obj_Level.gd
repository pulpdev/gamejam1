extends Node3D

class_name Level


## these are arbitrary. use then for ConditionVariables.
## id rather you not add your own or remove variables
@export var variables : Dictionary = {

	"plot" : 0,

	"stage": 0,

	"sequence" : 0,

	"counters" : 0,

	"objectives" : 0,

	"times" : 0

}

## player ref. automatically gets set.
@export var player : Character

## see which events are running.
@export var runningEvents : Array[Event]

## set current ambiance sound.
@export var ambiance : AudioStreamWAV


func _init():

	Global.player_entered.connect(

		func(p):

			player = p)


func _ready():

	Global.sfx.ambiance = ambiance

	Global.level_ready.emit()
	
	Global.sfx.music


func _on_child_entered_tree(node):

	if node is Character and node.name == "Player":

		player = node
