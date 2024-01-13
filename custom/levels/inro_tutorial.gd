extends Label


var starting : bool


func _process(delta):

	if Input.is_action_just_released("ui_cancel") and not starting:

		starting = true

		start()


func start():

	await get_tree().create_timer(0.1).timeout

	get_node("start").RunEvents()
