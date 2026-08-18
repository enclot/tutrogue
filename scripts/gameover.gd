class_name Gameover
extends CanvasLayer

@onready var label: Label = $TextureRect/Label

func set_win_message()->void:
	label.text = "Conguratulations!!\nYou brought back the One Ring"
