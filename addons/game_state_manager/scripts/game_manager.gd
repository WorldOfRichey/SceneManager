extends Node

@onready var scene_loader : SceneLoader = get_node("/root/GameManagment/SceneLoader")
@onready var current_scene_node : Node = get_node("/root/GameManagment/CurrentScene")
@onready var transitions_node : Node = get_node("/root/GameManagment/Transitions")
@onready var game_manager_settings : GameManagerSettings = get_node("/root/GameManagment")

func get_transitions_node(node_name : String) -> Node :
	return transitions_node.get_node(node_name)
