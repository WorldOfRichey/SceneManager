extends Node

func _on_load_prev_scene_button_pressed():
	GameManager.scene_loader.load_scene_quick("res://demo/scene1.tscn")

func _on_pause_button_pressed():
	GameManager.pause_game("SimplePause")
