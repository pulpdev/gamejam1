extends EventAction


## change ambiance to this sound
@export var sound : AudioStreamWAV


func _init():

	wait = true


func Execute():

	Global.sfx.ambiance = sound

	finished.emit()
