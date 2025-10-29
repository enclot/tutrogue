class_name InventoryUI
extends CanvasLayer

signal item_selected(item)

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var item_list: VBoxContainer = $PanelContainer/VBoxContainer/VBoxContainer


func build(window_title:String, player:Player) -> void:
	label.text = window_title
	#var inventory:InventoryComponent = player.get_component(InventoryComponent)
	#if inventory:
		#var items:Array[EntityResource] = inventory.items
		#for i in items.size():
			#_register_item(i, items[i])
		
	if item_list.get_child_count()>0:
		item_list.get_child(0).grab_focus()
		
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		item_selected.emit(null)
		queue_free() #menuを破棄
