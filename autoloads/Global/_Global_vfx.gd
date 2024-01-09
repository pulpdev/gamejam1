extends Node


@onready var fadetimer : Timer = $fadetimer

@onready var fade: ColorRect = $fade


func FadeIn(time : float = 0.0):

	if time <= 0.0:

		fade.color = Color(0,0,0,0)

		return

	var t = create_tween()

	t.tween_property(

		fade,

		"color",

		Color(0,0,0,0),

		time

	)


func FadeOut(time : float):
	
	if time <= 0.0:

		fade.color = Color(0,0,0,1)
		
		return

	var t = create_tween()

	t.tween_property(

		fade,

		"color",

		Color(0,0,0,1),

		time

	)
