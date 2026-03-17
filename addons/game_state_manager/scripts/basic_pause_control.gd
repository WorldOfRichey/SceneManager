extends PauseScreen

@onready var control : Control = get_node("Control")

func _show_pause_screen() -> void:
	control.visible = true
	
func _hide_pause_screen() -> void:
	control.visible = false

func _on_resume_pressed():
	GameManager.resume_game()

func _on_quit_pressed():
	GameManager.quit_game()
