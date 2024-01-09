extends Node3D

class_name Level


@export var player : Character

@export var runningEvents : Array[Event]

@export var ambiance : AudioStreamWAV :

	set(amb):

		ambiance = amb
		
		if ambiancePlayer:

			ambiancePlayer.stream = ambiance
	
			ambiancePlayer.play()


var ambiancePlayer : AudioStreamPlayer


func _init():

	Global.player_entered.connect(

		func(p):

			player = p)


func _ready():

	ambiancePlayer = AudioStreamPlayer.new()

	ambiancePlayer.stream = ambiance

	ambiancePlayer.volume_db = -10

	add_child(ambiancePlayer)

	ambiancePlayer.play()


func _on_child_entered_tree(node):

	if node is Character and node.name == "Player":

		player = node
