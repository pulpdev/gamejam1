extends Condition

class_name ConditionItem

## player must have this item. must be the FILENAME of an 'item' in the 'custom/items' folder.
@export var item : String


func ConditionMet():

	if Global.inventory.GetItemQuantity(item) > 0:

		return true

	return false
