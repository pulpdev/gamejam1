extends EventAction


@export var sound : AudioStreamWAV

@export var time : float = 1.0


var fadedOut : bool

var tween : Tween


func Execute():

	print(sound.resource_path)

	fadedOut = false

	tween = create_tween()

	tween.finished.connect(TweenFinished)

	tween.tween_property(

		get_tree().current_scene.ambiancePlayer,

		"volume_db",

		-80.0,

		time

	)


func TweenFinished():

	if not fadedOut:

		fadedOut = true

		get_tree().current_scene.ambiance = sound

		tween = create_tween()

		tween.finished.connect(TweenFinished)

		tween.tween_property(

		get_tree().current_scene.ambiancePlayer,

		"volume_db",

		Global.DEFAULT_AMB_DB,

		time

		)

	else:

		if wait:

			finished.emit()

