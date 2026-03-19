extends Node

@onready var scene_loader : SceneLoader = get_node("/root/SceneManagment/SceneLoader")
@onready var current_scene_node : Node = get_node("/root/SceneManagment/CurrentScene")
@onready var transitions_node : Node = get_node("/root/SceneManagment/Transitions")
@onready var scene_manager_settings : SceneManagerSettings = get_node("/root/SceneManagment")
@onready var pause_node : Node = get_node("/root/SceneManagment/Pause")

signal signal_on_scene_manager_state_changed

enum SceneManagerStates { PLAYING, PAUSED, LOADING, TRANSITION_IN, TRANSITION_OUT, QUITTING }

var current_state : SceneManagerStates = SceneManagerStates.PLAYING
var current_pause_screen : PauseScreen = null

func change_game_manager_state(new_state : SceneManagerStates) -> void :
	#If the new state is the old state do nothing.
	if current_state == new_state:
		return
		
	#Change the state and emit a signal
	var old_state = current_state
	current_state = new_state
	signal_on_scene_manager_state_changed.emit(old_state, current_state)

func get_transitions_node(node_name : String) -> Node :
	return transitions_node.get_node(node_name)
	
func get_pause_screen(node_name : String) -> PauseScreen :
	return pause_node.get_node(node_name)

func pause_game(node_name : String) -> void :
	#If we are already paused do nothing
	if current_state == SceneManagerStates.PAUSED:
		return
		
	#Set the pause ui and show
	current_pause_screen = get_pause_screen(node_name)
	current_pause_screen._show_pause_screen()
	
	#stop the tree
	get_tree().paused = true
	
	#Change the game state
	change_game_manager_state(SceneManagerStates.PAUSED)
	
func resume_game() -> void :
	#Is we are not paused return
	if current_state != SceneManagerStates.PAUSED:
		return
	
	#Resume the tree
	get_tree().paused = false
	
	#Hide the ui and change the game state
	current_pause_screen._hide_pause_screen()
	change_game_manager_state(SceneManagerStates.PLAYING)
	
func quit_game() -> void:
	#notify subscribers
	change_game_manager_state(SceneManagerStates.QUITTING)
	get_tree().quit()
