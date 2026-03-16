extends Node

@onready var scene_loader : SceneLoader = get_node("/root/GameManagment/SceneLoader")
@onready var current_scene_node : Node = get_node("/root/GameManagment/CurrentScene")
@onready var transitions_node : Node = get_node("/root/GameManagment/Transitions")
@onready var game_manager_settings : GameManagerSettings = get_node("/root/GameManagment")

signal signal_on_game_manager_state_changed

enum GameManagerStates { PLAYING, PAUSED, LOADING, TRANSITION_IN, TRANSITION_OUT }

var current_state : GameManagerStates = GameManagerStates.PLAYING

func change_game_manager_state(new_state : GameManagerStates) -> void :
	#If the new state is the old state do nothing.
	if current_state == new_state:
		return
		
	#Change the state and emit a signal
	var old_state = current_state
	current_state = new_state
	signal_on_game_manager_state_changed.emit(old_state, current_state)

func get_transitions_node(node_name : String) -> Node :
	return transitions_node.get_node(node_name)
