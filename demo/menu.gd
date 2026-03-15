extends Control

func _on_button1_pressed() -> void:
	GameManager.game_management.scene_loader.load_scene_quick("res://demo/menu2.tscn")

func _on_button2_pressed() -> void:
	GameManager.game_management.scene_loader.load_scene_quick("res://demo/menu.tscn")

func _on_load_scene_2_trans_pressed() -> void:
	GameManager.game_management.scene_loader.load_scene_with_transition("res://demo/menu2.tscn", "FadeTransition")
