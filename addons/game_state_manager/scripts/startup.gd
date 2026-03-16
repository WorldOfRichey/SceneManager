extends Node

#When this node is called it loads the main scene.
func _ready() -> void:
	load_initial_scene_defered.call_deferred()
	
func load_initial_scene_defered() -> void :
	#Load the first scene
	GameManager.game_management.scene_loader.load_scene_quick(GameManager.game_management.initial_scene)
	
	#Self distruct
	self.queue_free()
