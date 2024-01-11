extends Node3D


@export var player : Character

@export var runningEvents : Array[Event]


func _on_child_entered_tree(node):

	if node is Character and node.name == "Player":

		player = node


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
