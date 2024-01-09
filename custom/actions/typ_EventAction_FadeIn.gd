extends EventAction


@export var time : float = 0.0


func Execute():

	Global.vfx.FadeIn(time)

	if time <= 0.0:

		finished.emit()

		return

	else:

		$Timer.wait_time = time

		$Timer.start()


func _on_timer_timeout():

	if wait:

		finished.emit()
