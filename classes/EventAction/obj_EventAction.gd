extends Node

class_name EventAction


const CALL_EXECUTE : String = "Execute"


signal started

signal finished


## should this action fully finish what it's doing before starting the next one.
## for example, waiting for the 'Dialogue' action to finish means waiting until the text goes away.
## most actions will set this automatically to avoid bugs.
@export var wait : bool


var enabled : bool

var event : Event


func _init():

	started.connect(func(): enabled = true)

	finished.connect(func(): enabled = false)


func Run():

	started.emit()

	call(CALL_EXECUTE)
