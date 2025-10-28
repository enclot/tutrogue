extends ProgressBar

var actor:Actor

func _ready() -> void:
	var parent = get_parent()
	actor = parent.get_parent()
	if not actor:
		return
	#actorのcapabilty取得を待つ
	await actor.ready
	
	var stats = actor.get_component(StatsComponent)
	if stats:
		max_value = stats.max_hp
		value = stats.hp
		min_value = 0
		stats.hp_changed.connect(hp_changed)
		
	
func hp_changed(hp, max_hp) -> void:
	#print("%s hp changed %d %d"%[actor.entity_name, hp, max_hp])	
	max_value = max_hp
	value = hp
