extends EventAction

## time to wait. when time's up, next action will execute.
@export var time : float = 1.0


func _init():

	wait = true


func Execute():

	var timer : Timer = Timer.new()
	
	timer.one_shot = true
	
	timer.wait_time = time
	
	timer.timeout.connect(func():
		
		timer.queue_free()
		
		finished.emit()
		
	)
	
	add_child(timer)
	
	timer.start()
