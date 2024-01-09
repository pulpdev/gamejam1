extends Trigger

class_name Door


enum OPEN_TYPES {SWING, PUSH}


@onready var model := $Node3D


@export var locked : bool

@export var canClose : bool

@export var openType: OPEN_TYPES

@export var runEventsIfUnlocked : bool = false


var opened : bool


@onready var initPosition : Vector3 = global_position

@onready var initRotation : Vector3 = global_rotation


func Open():

	if locked:

		return

	match  openType:
		
		OPEN_TYPES.SWING:

			if not opened:
				print("opening")
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"global_rotation",
					
					global_rotation + Vector3(0,deg_to_rad(90),0),
					
					1
				)
				
				opened = true
				
			else:
				print("closing")
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"global_rotation",
					
					initRotation,
					
					1
				)
		
				opened = false
				
		OPEN_TYPES.PUSH:
			
			if not opened:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"global_position",
					
					global_position - Vector3(model.scale.x,0,0),
					
					1
				)
				
				opened = true
				
			else:
				
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"global_position",
					
					initPosition,
					
					1
				)
		
				opened = false
