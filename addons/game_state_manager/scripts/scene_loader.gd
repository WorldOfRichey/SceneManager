class_name SceneLoader
extends Node

var current_scene : Node = null
var scene_transition : SceneTransition = null
var next_scene_path : String
var scene_loading : bool = false
	
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
	
func load_scene_with_transition(scene_path : String, transition_name : String) -> void :
	next_scene_path = scene_path
	scene_transition = GameManager.game_management.get_transitions_node(transition_name)
	scene_transition.signal_in_transition_ended.connect(transition_in_completed)
	scene_transition._trigger_transition_in()
	
func transition_in_completed() -> void :
	scene_transition.signal_in_transition_ended.disconnect(transition_in_completed)
	begin_threaded_load()
	
func begin_threaded_load() -> void :
	begin_threaded_load_defered.call_deferred()
	
func begin_threaded_load_defered() -> void :
	if current_scene != null:
		current_scene.queue_free()
		
	ResourceLoader.load_threaded_request(next_scene_path, "")
	scene_loading = true
	
func add_thread_loaded_scene(node : Node) -> void :
	add_thread_loaded_scene_defered.call_deferred(node)
	
func add_thread_loaded_scene_defered(node : Node) -> void :
	current_scene = node
	GameManager.game_management.current_scene_node.add_child(current_scene)
	scene_transition.signal_out_transition_ended.connect(transition_out_completed)
	scene_transition._trigger_transition_out()
	
func transition_out_completed() -> void :
	scene_transition.signal_out_transition_ended.disconnect(transition_out_completed)
	print ("go")

func process_scene_loading() -> void:
	if (ResourceLoader.load_threaded_get_status(next_scene_path) == ResourceLoader.THREAD_LOAD_LOADED) :
		var node = ResourceLoader.load_threaded_get(next_scene_path).instantiate()
		add_thread_loaded_scene(node)
	
func _process(delta: float) -> void:
	if scene_loading:
		process_scene_loading()
