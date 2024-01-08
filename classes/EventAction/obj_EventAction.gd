extends Node

class_name EventAction


const CALL_EXECUTE : String = "Execute"


signal started

signal finished


@export var wait : bool


var enabled : bool

var event : Event


func _init():

	started.connect(func(): enabled = true)

	finished.connect(func(): enabled = false)


func Run():

	started.emit()

	call(CALL_EXECUTE)
