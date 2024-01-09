extends EventAction


func _init():
	
	wait = true
	
	
func Execute():
	
	if get_tree().current_scene.player:
		
		get_tree().current_scene.player.enableInput = true
		
	finished.emit()
