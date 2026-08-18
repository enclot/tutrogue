class_name Gameover
extends CanvasLayer

@onready var label: Label = $TextureRect/Label

enum Type {DIED, WIN, LOSE}
var type = Type.LOSE

func _ready() -> void:
	match type:
		Type.DIED:
			set_dead_message()
		Type.WIN:
			set_win_message()


func set_dead_message() -> void:
	label.text = "you died ..."

func set_win_message()->void:
	label.text = "Conguratulations!!\nYou brought back the One Ring"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneManager.swap_scenes("res://title_screen.tscn",
		 Gameplay.instance, self)
