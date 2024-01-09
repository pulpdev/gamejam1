extends Node3D

class_name Level


@export var player : Character

@export var runningEvents : Array[Event]


func _init():
	
	Global.player_entered.connect(
		
		func(p):
			
			player = p)


func _on_child_entered_tree(node):

	if node is Character and node.name == "Player":

		player = node
