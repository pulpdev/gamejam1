extends EventAction


@export var level : String

@export var fade : bool = true

@export_range(1.0, 10.0) var fadeTime : float = 1.0


func _init():
	
	wait = true


func Execute():

	if fade:

		var t = Timer.new()

		t.one_shot = true

		t.wait_time = fadeTime

		t.timeout.connect(

			func():

				Global.vfx.FadeIn(fadeTime)

				Global.scene.ChangeLevel(level)

		)

		add_child(t)

		Global.vfx.FadeOut(fadeTime)

		t.start()

	else:

		Global.scene.ChangeLevel(level)
