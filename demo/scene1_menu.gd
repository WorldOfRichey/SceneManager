extends Node
#Menu for testing game manager functions

func _on_load_next_scene_button_pressed():
	SceneManager.scene_loader.load_scene_with_transition("res://demo/scene2.tscn","FadeTransition")
	
func _on_load_next_scene_quick_button_pressed():
	SceneManager.scene_loader.load_scene_quick("res://demo/scene2.tscn")

func _on_pause_button_pressed():
	SceneManager.pause_game("BasicPause")
