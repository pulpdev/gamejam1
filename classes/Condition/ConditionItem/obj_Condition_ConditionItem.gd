extends Condition

class_name ConditionItem


@export var item : String


func ConditionMet():

	if Global.inventory.GetItemQuantity(item) > 0:

		return true

	return false
