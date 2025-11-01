class_name Gameover
extends CanvasLayer

@onready var label: Label = $TextureRect/Label

func set_win()->void:
	label.text = "Conguratulations!!\nYou brought back the One Ring"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SceneManager.swap_scenes("res://title_screen.tscn", Gameplay.instance, self)
