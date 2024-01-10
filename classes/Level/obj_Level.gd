extends Node3D

class_name Level

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
