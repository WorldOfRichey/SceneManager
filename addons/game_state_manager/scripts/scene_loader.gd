class_name SceneLoader
extends Node

signal signal_scene_loading

var current_scene : Node = null
var scene_transition : SceneTransition = null
var next_scene_path : String
var scene_loading : bool = false

#Call to load a scene with no transition.
func load_scene_quick(path : String) -> void :
	load_scene_quick_defered.call_deferred(path)
	
func load_scene_quick_defered(path : String) -> void :
	#Remove the current scene
	if current_scene != null:
		current_scene.queue_free()
	
	#Load the new scene and add the child into the scene
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	GameManager.game_management.current_scene_node.add_child(current_scene)
	
#Call to add a scene with a scene transition. 
#The screne transition covers the screen, the new scene is loaded 
#And the scene transition reveals the screen.
func load_scene_with_transition(scene_path : String, transition_name : String) -> void :
	#Store variables
	next_scene_path = scene_path
	scene_transition = GameManager.game_management.get_transitions_node(transition_name)
	
	#Begin the in transition and wait for a signal it has ended.
	scene_transition.signal_in_transition_ended.connect(transition_in_completed)
	scene_transition._trigger_transition_in()

#Called from the transition in, when it is completed. We can now
#load the next screne.
func transition_in_completed() -> void :
	scene_transition.signal_in_transition_ended.disconnect(transition_in_completed)
	begin_threaded_load_defered.call_deferred()

#Begins loading a scene from resources.
func begin_threaded_load_defered() -> void :
	#Delete the current scene.
	if current_scene != null:
		current_scene.queue_free()
	
	#Start loading and set the loading flag
	ResourceLoader.load_threaded_request(next_scene_path, "")
	scene_loading = true
	
#Called from the process loop when the resource loader
#has finished loading a scene
func add_thread_loaded_scene_defered(node : Node) -> void :
	#set the current scene and add it to the tree
	current_scene = node
	GameManager.game_management.current_scene_node.add_child(current_scene)
	
	#begin the transition out and wait for a signal it is complete.
	scene_transition.signal_out_transition_ended.connect(transition_out_completed)
	scene_transition._trigger_transition_out()
	
#Called when the transition is complete.
func transition_out_completed() -> void :
	scene_transition.signal_out_transition_ended.disconnect(transition_out_completed)

#Called from the process thread.
#Checks the status of the loading scene
func process_scene_loading() -> void:
	var progress_array = []
	
	#Get the current status
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress_array)
	
	#If we have loaded, add the scene and unset the loading flag
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var node = ResourceLoader.load_threaded_get(next_scene_path).instantiate()
		add_thread_loaded_scene_defered.call_deferred(node)
		scene_loading = false
		return
	
	#If we are loading broadcase the loading signal
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS :
		var percentage = progress_array[0]
		signal_scene_loading.emit(percentage)
	
func _process(delta: float) -> void:
	if scene_loading:
		process_scene_loading()
