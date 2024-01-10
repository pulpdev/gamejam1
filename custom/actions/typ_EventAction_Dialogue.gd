extends EventAction

## self explanitory
@export_multiline var text : String

var timer : Timer


var wtf : int = 0


func Execute():

	Global.dialogue.text = text

	if wait:

		timer = Timer.new()

		add_child(timer)

		timer.timeout.connect(timeout)

		timer.wait_time = Global.dialogue.GetTextDisplayTime(text)

		timer.one_shot = true

		timer.start()

	else:

		finished.emit()


func timeout():

	timer.queue_free()

	if wait:

		finished.emit()
