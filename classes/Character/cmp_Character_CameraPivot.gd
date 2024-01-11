extends Node3D


const MAX_ROTATION : Vector2 = Vector2(-90,90)


@onready var camera : Camera3D = $Camera3D

@onready var usearea := $UseArea

@onready var flashlight := $Flashlight


var vector_view : Vector3

var vector_mouse : Vector2

@onready var init_position : Vector3 = position


func _ready():
	
	usearea.add_exception(owner)


func _input(event):

	if event is InputEventMouseMotion:

		vector_mouse.x = -event.relative.y * 1

		vector_mouse.y = -event.relative.x * 1


func _process(delta):

	vector_view.x += vector_mouse.x * delta

	vector_view.x = clamp(vector_view.x, deg_to_rad(-90),deg_to_rad(90))

	vector_view.y += vector_mouse.y * delta

	transform.basis = Basis.from_euler(Vector3(vector_view.x,0,0))

	rotation.z = 0

	vector_mouse = Vector2.ZERO


func _physics_process(delta):

	ActivateTrigger(usearea.get_collider())

	#ActivateTriggers(usearea.get_overlapping_areas())


func ActivateTrigger(obj : Object):

	if obj == null:

		return
		
	var trigger

	if not obj.owner is Trigger:
		
		if not obj.owner.get_parent() is Trigger:

			return
			
		else:
			
			trigger = obj.owner.get_parent()
			
	else:

		trigger = obj.owner

	if not trigger.type == Trigger.TYPES.ACTIVATE:

		return

	if Input.is_action_just_pressed("action_use"):
		
		trigger.RunEvents()
		
		if trigger is Door:
#
			if not trigger.canClose:
#
				if trigger.opened:
#
					return
#
			trigger.Open()





#func ActivateTriggers(triggers : Array):
#
	#for thing in triggers:
#
		#if not thing.owner is Trigger:
			#
			#triggers.pop_at(triggers.find(thing))
			#
		#if thing.owner is Trigger and thing.owner.type == Trigger.TYPES.TOUCH:
			#
			#triggers.pop_at(triggers.find(thing))
#
		#if thing.name == "blocker":
#
			#triggers.pop_at(triggers.find(thing))
#
	#if triggers.size() == 0:
#
		#return
#
	#if triggers.front().owner is Trigger:
#
		#var trigger = triggers.front().owner
#
		#if trigger.type == Trigger.TYPES.ACTIVATE and Input.is_action_just_pressed("action_use"):
#
			#trigger.RunEvents()
#
			#if trigger is Door:
#
				#if not trigger.canClose:
#
					#if trigger.opened:
#
						#return
#
				#trigger.Open()
