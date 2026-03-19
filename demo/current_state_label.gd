extends Label
#This label observes GameManager.current_state changes

func _ready():
	SceneManager.signal_on_scene_manager_state_changed.connect(on_state_change)
	text = str(SceneManager.SceneManagerStates.keys()[SceneManager.current_state])
	
func on_state_change(old_state : SceneManager.SceneManagerStates, new_state : SceneManager.SceneManagerStates) -> void :
	var new_text = str(SceneManager.SceneManagerStates.keys()[new_state])
	var old_text = str(SceneManager.SceneManagerStates.keys()[old_state])
	
	text = "%s was %s" % [new_text, old_text]
