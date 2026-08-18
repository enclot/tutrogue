class_name TitleScreen
extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var unload_node = self
		if Gameplay.instance:
			unload_node = Gameplay.instance
		SceneManager.swap_scenes("res://gameplay.tscn", null, unload_node)
