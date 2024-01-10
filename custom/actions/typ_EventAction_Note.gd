extends EventAction


@export_multiline var text : String


var bg : ColorRect

var note : Label

var canClose : bool

var sound = load("res://assets/sounds/note_1.wav")

var player : AudioStreamPlayer


func _init():

	wait = true


func Execute():
	
	get_tree().current_scene.player.enableInput = false

	bg = ColorRect.new()

	add_child(bg)

	bg.anchors_preset = ColorRect.PRESET_FULL_RECT

	bg.color = Color(0,0,0,0)
	
	note = Label.new()
	
	add_child(note)
	
	note.anchors_preset = ColorRect.PRESET_FULL_RECT
	
	note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	note.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	note.text = text
	
	note.modulate = Color(0,0,0,0)
	
	player = AudioStreamPlayer.new()
	
	add_child(player)
	
	player.stream = sound
	
	player.play()

	var t = create_tween().set_parallel()
	
	t.finished.connect(TweenFinished)

	t.tween_property(

		bg,

		"color",

		Color(0,0,0,0.8),

		1

	)

	t.tween_property(

		note,

		"modulate",

		Color(1,1,1,1),

		1

	)


func _process(delta):

	if Input.is_action_just_released("mouse_1") and canClose:

		note.queue_free()

		bg.queue_free()
		
		player.queue_free()

		canClose = false
		
		get_tree().current_scene.player.enableInput = true

		finished.emit()


func TweenFinished():

	canClose = true
