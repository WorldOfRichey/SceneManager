extends Label
#This label observes GameManager.current_state changes

func _ready():
	GameManager.signal_on_game_manager_state_changed.connect(on_state_change)
	text = str(GameManager.GameManagerStates.keys()[GameManager.current_state])
	
func on_state_change(old_state : GameManager.GameManagerStates, new_state : GameManager.GameManagerStates) -> void :
	var new_text = str(GameManager.GameManagerStates.keys()[new_state])
	var old_text = str(GameManager.GameManagerStates.keys()[old_state])
	
	text = "%s was %s" % [new_text, old_text]
