extends Node


func _input(event):

	if Input.is_action_just_pressed("debug_quit"):

		get_tree().quit()

	if Input.is_action_just_pressed("debug_pause"):
		
		var mode = get_tree().current_scene.process_mode
		
		if mode == Node.PROCESS_MODE_DISABLED:

			get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
			
		else:
			
			get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
