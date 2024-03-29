extends EventAction


@export_range(0.1, 10.0) var duration : float

@export_enum("Attack1", "Pose", "Walk") var animation : String = "Pose"


var monster : Node3D

var timer : Timer

var canMove : bool



func Execute():

	canMove = false

	monster = load("res://custom/monsters/maxdamage_zombie_low_poly.tscn").instantiate()

	add_child(monster)

	monster.global_position = event.trigger.global_position

	monster.global_rotation = event.trigger.global_rotation

	if not wait:

		finished.emit()

	timer = Timer.new()

	timer.wait_time = duration

	timer.one_shot = true

	monster.add_child(timer)

	var stat = StaticBody3D.new()

	var col = CollisionShape3D.new()

	monster.add_child(stat)
	
	stat.add_child(col)

	col.shape = BoxShape3D.new()

	timer.timeout.connect(func():

		timer.get_parent().queue_free()

		if wait:

			finished.emit()

		)

	timer.start()

	monster.get_node("AnimationPlayer").play(animation)

	if animation == "Walk":

		monster.get_node("AnimationPlayer").speed_scale = 2.0

		canMove = true
		
	else:
		
		monster.get_node("AnimationPlayer").speed_scale = 1.0
		
		canMove = false

	print(monster)


func _physics_process(delta):

	if is_instance_valid(monster):

		monster.global_rotation.z = 0

		monster.global_rotation.x = 0

		monster.look_at(get_tree().current_scene.player.global_position)

		if canMove:

			monster.global_position -= monster.transform.basis.z * 0.01
		
