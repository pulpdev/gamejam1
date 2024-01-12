extends Node


const BASE_SHOW_TIME : float = 3.0


@onready var window : Label = $Label

@onready var timer : Timer = $Timer


var text : String :

	set(s):

		timer.stop()

		text = s

		window.text = text

		timer.wait_time = GetTextDisplayTime(text)

		timer.start()


func GetTextDisplayTime(string : String):

	return BASE_SHOW_TIME + (string.length() / 40)


func _on_timer_timeout():

	window.text = ""
