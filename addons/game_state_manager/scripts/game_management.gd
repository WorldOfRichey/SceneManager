class_name GameManagement
extends Node

@onready var scene_loader : SceneLoader = get_node("SceneLoader")
@onready var current_scene_node : Node = get_node("CurrentScene")
@onready var transitions_node : Node = get_node("Transitions")

@export_file_path("*.tscn") var initial_scene : String = ""

func get_transitions_node(node_name : String) -> Node :
	return transitions_node.get_node(node_name)
