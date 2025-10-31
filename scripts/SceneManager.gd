extends Node

signal scene_added(loaded_scene:Node)
signal load_complete(loaded_scene:Node)

const LOADING_SCREEN = preload("res://loading_screen.tscn")
var _loading_screen:LoadingScreen

var _loading_in_progress:bool = false
var _content_path:String
var _load_scene_into:Node #
var _scene_to_unload:Node #

func _ready() -> void:
	pass
	
func _add_loading_screen() -> void:
	_loading_screen = LOADING_SCREEN.instantiate() as LoadingScreen
	get_tree().root.add_child(_loading_screen)

	_loading_screen.start_transition()

func _load_content(content_path:String) -> void:
	_content_path = content_path
	var loader = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		printerr("error: Cannot load resource: '%s'" % [content_path])
		return
	
	while loader == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
		loader = ResourceLoader.load_threaded_get_status(content_path)
	
	var incoming_scene:Node = ResourceLoader.load_threaded_get(content_path).instantiate()
	if _scene_to_unload:
		if _scene_to_unload != get_tree().root: 
			_scene_to_unload.queue_free()
			await _scene_to_unload.tree_exited

	_load_scene_into.add_child(incoming_scene)
	scene_added.emit(incoming_scene)
	#_ready()がすぐ呼ばれる

	if _loading_screen:
		_loading_screen.finish_transition()
		#await _loading_screen.animation_player.animation_finished
	
	_loading_in_progress = false
	
	load_complete.emit(incoming_scene)
	
	
func swap_scenes(scene_to_load:String, load_into:Node=null, scene_to_unload:Node=null)-> void:
	if _loading_in_progress:
		push_warning("SceneManager is already loading something")
		return
	_loading_in_progress = true
	
	if not load_into:
		load_into = get_tree().root
	_load_scene_into = load_into
	_scene_to_unload = scene_to_unload
	
	_add_loading_screen()
	_load_content(scene_to_load)	
