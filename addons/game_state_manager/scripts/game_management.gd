class_name GameManagement
extends Node

@onready var scene_loader : SceneLoader = get_node("SceneLoader")
@onready var current_scene_node : Node = get_node("CurrentScene")

@export
var initial_scene : String = ""
