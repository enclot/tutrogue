class_name Gameplay
extends Node2D

static var instance:Gameplay

var current_level:BaseLevel

var player_scene:PackedScene#Playrはすべてのレベルに共通
var level_data_set:LevelDataSet #レベルのパスがキーのDictionary

func _ready() -> void:
	instance = self
	
	current_level = get_child(0) as BaseLevel
	SceneManager.scene_added.connect(_on_level_added)
	SceneManager.scene_adding.connect(_on_level_adding)
	
	level_data_set = LevelDataSet.new()
	
#ここが呼ばれるときは_ready()の前
func _on_level_adding(level:Node)->void:
	if level is not BaseLevel:
		return
	
	load_level_grid_objects(level)

#ここが呼ばれるときは_ready()が終わった後
func _on_level_added(level) -> void:
	if level is BaseLevel:
		current_level = level
		
		
func level1():
	SceneManager.swap_scenes("res://level_1.tscn", self, current_level)
	save_level_grid_objects(current_level)
func level2():
	SceneManager.swap_scenes("res://level_2.tscn", self, current_level)
	save_level_grid_objects(current_level)


func save_level_grid_objects(_level:BaseLevel) -> void:	
	var grid_objects = LevelGridObjectData.new()

	for obj in get_tree().get_nodes_in_group(&"grid_object"):
		if obj is Player:
			player_scene = PackedScene.new()
			player_scene.pack(obj)
			continue
			
		var scene = PackedScene.new()
		scene.pack(obj)
		grid_objects.grid_object_scenes.append(scene)
		
	level_data_set.levels[current_level.scene_file_path] = \
		 grid_objects.duplicate()
	
func load_level_grid_objects(level:BaseLevel) -> void:

	var is_first_visit:bool = \
		not level_data_set.levels.has(level.scene_file_path)
		
	# 全部消す
	for child in level.get_children():
		if child.is_in_group(&"grid_object"):
			# 初めて訪れた場合はプレイヤー以外はそのまま
			if is_first_visit:
				if not child.is_in_group(&"player"):
					continue
			#すぐツリーから消しておかないとダブってるときがある
			level.remove_child(child)
			child.queue_free()

	#playerをデータから復元
	level.spawn_grid_object(player_scene)
	
	if is_first_visit:
		return
		
	#ほかを復元
	var level_grid_object_data:LevelGridObjectData = \
		level_data_set.levels[level.scene_file_path]  
	for obj in level_grid_object_data.grid_object_scenes:
		level.spawn_grid_object(obj)
