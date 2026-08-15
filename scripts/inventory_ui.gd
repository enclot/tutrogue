class_name InventoryUI
extends CanvasLayer

signal item_selected(item)

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var item_list: VBoxContainer = \
	$PanelContainer/VBoxContainer/VBoxContainer

		
func _ready() -> void:
	if item_list.get_child_count()>0:
		item_list.get_child(0).grab_focus()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		item_selected.emit(null)
		queue_free() #UIを破棄	
