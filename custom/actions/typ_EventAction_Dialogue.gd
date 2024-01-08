extends EventAction


@export_multiline var text : String


func _init():

	wait = false


func Execute():
	
	Global.dialogue.text = text
	
	if wait:

		var timer : Timer = Timer.new()

		timer.wait_time = Global.dialogue.GetTextDisplayTime(text)
		
		timer.one_shot = true
		
		timer.timeout.connect(

			func():
			
				timer.queue_free()
				
				finished.emit())
				
		add_child(timer)
		
		timer.start()

	else:

		finished.emit()
