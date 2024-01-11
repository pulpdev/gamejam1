extends EventAction


@export_range(0.1, 10.0) var duration : float

@export_enum("Attack1", "Pose", "Walk") var animation : String = "Pose"


var monster : Node3D

var timer : Timer

var canMove : bool


func Execute():
	
	canMove = false

	monster = load("res://custom/models/maxdamage_zombie-low-poly.gltf").instantiate()

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

		canMove = true


	print(monster)


func _physics_process(delta):

	if canMove and is_instance_valid(monster):

		monster.global_position.z -= 0.01
