extends Node

func _ready() -> void:
	load_initial_scene_defered.call_deferred()
	
func load_initial_scene_defered() -> void :
	GameManager.game_management.scene_loader.load_scene_quick(GameManager.game_management.initial_scene)
