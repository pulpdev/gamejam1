extends Node3D


const MAX_ROTATION : Vector2 = Vector2(-90,90)


@onready var camera : Camera3D = $Camera3D

@onready var usearea := $UseArea

@onready var flashlight := $Flashlight


var vector_view : Vector3

var vector_mouse : Vector2


func _input(event):

	if event is InputEventMouseMotion:

		vector_mouse.x = -event.relative.y * 0.5

		vector_mouse.y = -event.relative.x * 0.5


func _process(delta):

	vector_view.x += vector_mouse.x * delta

	vector_view.x = clamp(vector_view.x, deg_to_rad(-90),deg_to_rad(90))

	vector_view.y += vector_mouse.y * delta

	transform.basis = Basis.from_euler(Vector3(vector_view.x,0,0))

	rotation.z = 0

	vector_mouse = Vector2.ZERO


func _physics_process(delta):

	ActivateTriggers(usearea.get_overlapping_areas())


func ActivateTriggers(triggers : Array):

	if triggers.size() == 0:

		return

	if triggers.front().owner is Trigger:

		var trigger = triggers.front().owner

		if trigger.type == Trigger.TYPES.ACTIVATE and Input.is_action_just_pressed("action_use"):

			trigger.RunEvents()