@tool
class_name HealingPotion extends Item

func activate() -> Action:
	return HealingAction.new(100)
