class_name InventoryUI
extends CanvasLayer

signal item_selected(item:EntityResource)

@onready var label: Label = $PanelContainer/VBoxContainer/Label
@onready var item_list: VBoxContainer = \
	$PanelContainer/VBoxContainer/VBoxContainer

var button_copy:Button

func initialize(_label_text:String, _list:Array[EntityResource]):
	label.text = _label_text
	for item:EntityResource in _list:
		var item_button = button_copy.duplicate()
		item_button.text = item.entity_name
		item_button.pressed.connect(button_pressed.bind(item))
		item_list.add_child(item_button)
	if item_list.get_child_count()>0:
		item_list.get_child(0).grab_focus()
		
func _ready() -> void:
	if item_list.get_child_count()>0:
		# コピーしておく
		button_copy = item_list.get_child(0).duplicate()
		
	# 全部消す
	for child in item_list.get_children():
		item_list.remove_child(child)
		child.queue_free()	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		item_selected.emit(null)
		queue_free() #UIを破棄	

func button_pressed(item: EntityResource) -> void:
	item_selected.emit(item)
	queue_free() #UIを破棄
