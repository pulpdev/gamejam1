extends Node


const LEVELS_DIR : String = "res://custom/levels/"


func ChangeLevel(levelname : String):

	var level = load(LEVELS_DIR + levelname + ".tscn")

	get_tree().call_deferred("change_scene_to_packed", level)
