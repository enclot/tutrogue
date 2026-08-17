class_name LoadingScreen
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const starting_animation_name ="fade_to_black"
const ending_animation_name = "fade_from_black"

func _ready() -> void:
	await get_tree().process_frame

func start_transition() -> void:
	animation_player.play(starting_animation_name)

func finish_transition() -> void:
	animation_player.play(ending_animation_name)
	await animation_player.animation_finished
	queue_free()
