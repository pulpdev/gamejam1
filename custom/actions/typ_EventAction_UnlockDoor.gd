extends EventAction


func _init():

	wait = true


func Execute():

	var s = AudioStreamPlayer3D.new()
	
	s.stream = load("res://assets/sounds/doorlocked_1.wav")
	
	s.finished.connect(
		
		func():
			
			s.queue_free()

	)
	
	add_child(s)
	
	s.pitch_scale = 2.0
	
	s.global_position = event.trigger.global_position
	
	s.play()


	if event.trigger is Door:

		event.trigger.locked = false

	finished.emit()
