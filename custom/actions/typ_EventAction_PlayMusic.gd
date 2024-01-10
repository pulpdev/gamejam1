extends EventAction


@export var music : AudioStreamWAV


func _init():
	
	wait = true
	
	
func Execute():
	
	Global.sfx.music = music
	
	finished.emit()
