extends Trigger

class_name Door


@export var locked : bool

@export var runEventsIfUnlocked : bool = false


var opened : bool


func Open():

	if locked:

		return

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
