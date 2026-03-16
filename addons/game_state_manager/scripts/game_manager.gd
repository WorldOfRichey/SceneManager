extends Node

@onready var scene_loader : SceneLoader = get_node("/root/GameManagment/SceneLoader")
@onready var current_scene_node : Node = get_node("/root/GameManagment/CurrentScene")
@onready var transitions_node : Node = get_node("/root/GameManagment/Transitions")
@onready var game_manager_settings : GameManagerSettings = get_node("/root/GameManagment")
@onready var pause_node : Node = get_node("/root/GameManagment/Pause")

signal signal_on_game_manager_state_changed

enum GameManagerStates { PLAYING, PAUSED, LOADING, TRANSITION_IN, TRANSITION_OUT }

var current_state : GameManagerStates = GameManagerStates.PLAYING
var current_pause_screen : PauseScreen = null

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
	
func get_pause_screen(node_name : String) -> PauseScreen :
	return pause_node.get_node(node_name)

func pause_game(node_name : String) -> void :
	#If we are already paused do nothing
	if current_state == GameManagerStates.PAUSED:
		return
		
	#Set the pause ui and show
	current_pause_screen = get_pause_screen(node_name)
	current_pause_screen._show_pause_screen()
	
	#stop the tree
	get_tree().paused = true
	
	#Change the game state
	change_game_manager_state(GameManagerStates.PAUSED)
	
func resume_game() -> void :
	#Is we are not paused return
	if current_state != GameManagerStates.PAUSED:
		return
	
	#Resume the tree
	get_tree().paused = false
	
	#Hide the ui and change the game state
	current_pause_screen._hide_pause_screen()
	change_game_manager_state(GameManagerStates.PLAYING)
