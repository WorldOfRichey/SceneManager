class_name SceneLoader
extends Node

var current_scene : Node = null
	
func delete_scene_node() -> void:
	if current_scene != null:
		current_scene.queue_free()

func load_scene_quick(path : String) -> void :
	load_scene_quick_defered.call_deferred(path)
	
func load_scene_quick_defered(path : String) -> void :
	if current_scene != null:
		current_scene.queue_free()
		
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	GameManager.game_management.current_scene_node.add_child(current_scene)
