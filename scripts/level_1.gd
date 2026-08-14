class_name Level1
extends Node2D

@onready var player: Player = $Player
@onready var input_handler: GameInputHandler = $GameInputHandler
@onready var map: Map = $Map

func _ready() -> void:
	player.input_handler = input_handler
	
	#シーンツリーに配置されているActorにMapの参照を渡す
	for node in get_tree().get_nodes_in_group(&"actor"):
		var actor = node as Actor
		if actor:
			actor.map = map
			
	while true:
		for node in get_tree().get_nodes_in_group(&"actor"):
			var actor = node as Actor
			if actor:
				while true:
					var action:Action = await _get_actor_action(actor)
					if _perform_action(action, actor):
						break
				
		map.update_navigation_costs()		
		
func _get_actor_action(_actor:Actor) -> Action:
	if _actor is Player:
		return await (_actor as Player).get_action()
	return _actor.get_action()
	


func _perform_action(_action:Action, _actor:Actor) ->bool:
	var current = _action
	while current:
		var result:ActionResult = current.perform(_actor)
		if result.succeeded:
			# succeeded==true
			return true
		if result.alternative == null:
			# succeeded==false and alternative==null
			return false	
			
		current = result.alternative	
	return true
