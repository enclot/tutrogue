class_name Gameplay
extends Node2D

static var instance:Gameplay

var current_level:BaseLevel

var player_data:PackedScene#playrは新しいレベルに行くたびに更新していく必要があるので別に保存する
var level_data:LevelData #レベルのパスがキーのDictionary

func _ready() -> void:
	instance = self
	
	current_level = get_child(0) as BaseLevel
	SceneManager.scene_added.connect(_on_level_added)	
	
	level_data = LevelData.new()
	
func _on_level_added(level) -> void:
	if level is BaseLevel:
		current_level = level
		
		Gameplay.instance.load_level_actors()

		
func level1():
	SceneManager.swap_scenes("res://level_1.tscn", self, current_level)
	
func level2():
	SceneManager.swap_scenes("res://level_2.tscn", self, current_level)

func save_level_actors() -> void:
	var level_actor_data = LevelActorData.new()#Player以外のActorが入る
	var actor_nodes = current_level.map.get_actors_in_group("actor")
	for actor in actor_nodes:
		if actor is Player:
			continue
			
		var actor_scene = PackedScene.new()
		actor_scene.pack(actor)
		level_actor_data.actor_array.append(actor_scene)		
	level_data.levels[current_level.scene_file_path] = level_actor_data.duplicate()
	
	var player_scene = PackedScene.new()
	player_scene.pack(current_level.map.get_player_actor())
	player_data = player_scene


	
func load_level_actors() -> void:
	#もともとのplayerを消す
	current_level.player.queue_free()
	await current_level.player.tree_exited
	
	#playerをデータから復元
	var loaded_player:Player = player_data.instantiate()
	loaded_player.initialize()
	current_level.map.actors_holder.add_child(loaded_player)
	current_level.reset_player()
	
	#初めてのレベルの時はプレイヤーだけ読み込みほかのActorは初期状態のままにする
	if not level_data.levels.has(current_level.scene_file_path):
		return

	#Player以外を消す
	var actor_nodes =  current_level.map.get_actors_in_group("actor")
	for actor in actor_nodes:
		if actor is Player:
			continue
		actor.queue_free()
			
	var level_actor_data:LevelActorData = level_data.levels[current_level.scene_file_path]  
	for actor in level_actor_data.actor_array:
		var actor_node:Actor = actor.instantiate()
		actor_node.initialize()
		current_level.map.actors_holder.add_child(actor_node)
		actor_node.map = current_level.map
		

	
