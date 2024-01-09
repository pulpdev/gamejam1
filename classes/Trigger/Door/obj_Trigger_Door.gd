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


func Open():

	if locked:

		return

	match  openType:
		
		OPEN_TYPES.SWING:

			if not opened:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"rotation_degrees",
					
					Vector3(0,-90,0),
					
					1
				)
				
				opened = true
				
			else:
				
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"rotation_degrees",
					
					Vector3(0,0,0),
					
					1
				)
		
				opened = false
				
		OPEN_TYPES.PUSH:
			
			if not opened:

				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"position",
					
					position - Vector3(model.scale.x,0,0),
					
					1
				)
				
				opened = true
				
			else:
				
				var t = create_tween()
				
				t.tween_property(
					
					self,
					
					"position",
					
					initPosition,
					
					1
				)
		
				opened = false
