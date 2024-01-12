extends Node


const DEFAULT_AMB_DB : float = -10.0



signal music_finished


@onready var musicPlayer : AudioStreamPlayer = $MusicPlayer

@onready var ambiancePlayer : AudioStreamPlayer = $AmbiancePlayer


@export var ambiance : AudioStreamWAV :

	set(a):

		#if a == null:
#
			#return
#
		#else:

			ambiance = a

			var t = create_tween()
	
			t.finished.connect(

				func():
					
					var t2 = create_tween()

					ambiancePlayer.stream = a
					
					ambiancePlayer.volume_db = -30

					ambiancePlayer.play()
					
					t2.tween_property(
						
						ambiancePlayer,
						
						"volume_db",

						DEFAULT_AMB_DB,

						1

					)
			)

			t.tween_property(

				ambiancePlayer,

				"volume_db",

				-80.0,

				1

			)


@export var music : AudioStreamWAV :

	set(m):

		music = m

		if music == null : 

			return

		musicPlayer.stream = music

		musicPlayer.play()


func _on_music_player_finished():

	music = null
