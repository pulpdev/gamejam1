extends Node


const BASE_SHOW_TIME : float = 3.0


@onready var window := $Label

@onready var timer := $Timer


var text : String :

	set(s):

		timer.stop()

		text = s

		window.text = text

		timer.wait_time = GetTextDisplayTime(text)

		timer.start()


func GetTextDisplayTime(string : String):

	return BASE_SHOW_TIME + (string.length() / 50)


func _on_timer_timeout():

	window.text = ""
