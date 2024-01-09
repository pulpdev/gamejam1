extends Condition

class_name ConditionItem


@export var item : String

@export_range(0, 999999) var amount : int = 0


func ConditionMet():

	if Global.inventory.GetItemQuantity(item) == amount:

		return true

	return false
