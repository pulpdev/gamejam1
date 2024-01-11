extends EventAction

## sound to play
@export var sound : AudioStreamWAV

## sound volume. 0.0 is the default volume
@export_range(-80.0, 10.0) var volume : float = 0.0

## does the sound play right in your ears or from where the trigger is
@export var nonPositional : bool


var player



func _ready():
	
	if nonPositional:
		
		player = AudioStreamPlayer.new()
		
		add_child(player)
		
	else:
		
		player = AudioStreamPlayer3D.new()
		
		add_child(player)
		
		player.global_position = event.trigger.global_position

	player.volume_db = volume

	player.stream = sound
	
	player.finished.connect(_on_audio_stream_player_finished)


func Execute():

	player.play()

	if not wait:

		finished.emit()


func _on_audio_stream_player_finished():

	if wait:
		
		finished.emit()
