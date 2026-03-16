extends Control

func load_scene_one_quick() -> void:
	GameManager.scene_loader.load_scene_quick("res://demo/menu.tscn")
	
func load_scene_two_quick() -> void:
	GameManager.scene_loader.load_scene_quick("res://demo/menu2.tscn")
	
func load_scene_one_trans() -> void:
	GameManager.scene_loader.load_scene_with_transition("res://demo/menu2.tscn", "FadeTransition")
	
func load_scene_two_trans() -> void:
	GameManager.scene_loader.load_scene_with_transition("res://demo/menu2.tscn", "FadeTransition")

func pause_game() -> void:
	GameManager.pause_game("SimplePause")
	
func resume_game() -> void:
	GameManager.resume_game()
