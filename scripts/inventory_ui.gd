class_name InventoryUI
extends CanvasLayer

signal item_selected(item)

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var item_list: VBoxContainer = $PanelContainer/VBoxContainer/VBoxContainer

const INVENTORY_ITEM = preload("res://inventory_item.tscn")	


func build(window_title:String, player:Player) -> void:
	label.text = window_title

	for child in item_list.get_children():
		item_list.remove_child(child)
		child.queue_free()	
				
	var inventory:InventoryComponent = player.get_component(InventoryComponent)
	if inventory:
		var items:Array[EntityResource] = inventory.items
		for i in items.size():
			_register_item(i, items[i])
		
	if item_list.get_child_count()>0:
		item_list.get_child(0).grab_focus()
		
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		item_selected.emit(null)
		queue_free() #menuを破棄

func _register_item(_index: int, item:EntityResource) -> void:
	var item_button:Button = INVENTORY_ITEM.instantiate()
	item_button.text = item.entity_name
	item_button.pressed.connect(button_pressed.bind(item))
	item_list.add_child(item_button)
	
func button_pressed(item: EntityResource) -> void:
	item_selected.emit(item)
	queue_free() #UIを破棄
