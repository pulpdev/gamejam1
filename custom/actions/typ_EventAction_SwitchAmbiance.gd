extends EventAction

#depricated dont use


func _init():

	wait = true


func Execute():
	
	finished.emit()
	
	return
	
	if get_tree().current_scene.ambianceMode == 0:
		
		get_tree().current_scene.ambianceMode = 1
		
	elif get_tree().current_scene.ambianceMode == 1:
		
		get_tree().current_scene.ambianceMode = 0
		
	finished.emit()
