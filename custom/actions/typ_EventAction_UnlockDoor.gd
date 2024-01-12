extends EventAction


func _init():

	wait = true


func Execute():

	if event.trigger is Door:

		if event.trigger.locked == false:
			
			pass
			
		else:

			var s = AudioStreamPlayer3D.new()
			
			s.stream = load("res://assets/sounds/snake_unlock_1.wav")
			
			s.finished.connect(
				
				func():
					
					s.queue_free()

			)

			add_child(s)

			s.pitch_scale = 1.0

			s.global_position = event.trigger.global_position

			s.play()
			
			event.trigger.locked = false

	finished.emit()
