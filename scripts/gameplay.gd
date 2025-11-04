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
		
	elif level is Gameover:
		var loaded_player:Player = player_data.instantiate()
		loaded_player.initialize()
		
		var stats:StatsComponent = loaded_player.get_component(StatsComponent)
		if not stats.is_alive():
			level.set_dead_message()
			return
		
		var inventory:InventoryComponent = loaded_player.get_component(InventoryComponent)
		var items = inventory.items
		for item:EntityResource in items:
			print(item.entity_name)
			if item.entity_name == "One Ring":
				level.set_win_message()
				return


func show_gameover() -> void:
	SceneManager.swap_scenes("res://gameover.tscn", self, current_level)

func shift_level(offset:int)->void:
	var current_path = current_level.scene_file_path
	var parts = current_path.split("_")
	var num_part = parts[1].split(".")[0]
	var new_number = int(num_part) + offset
	var new_path = parts[0] + "_" + str(new_number) + ".tscn"
	SceneManager.swap_scenes(new_path, self, current_level)
	
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
		
func add_actor(actor_node:Actor)->void:
	current_level.map.actors_holder.add_child(actor_node)
