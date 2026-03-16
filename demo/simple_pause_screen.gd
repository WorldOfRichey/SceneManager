extends PauseScreen

@onready var pause_control : Control = get_node("Control")

func _show_pause_screen() -> void:
	pause_control.visible = true
	
func _hide_pause_screen() -> void:
	pause_control.visible = false

func on_resume_clicked() -> void:
	GameManager.resume_game()
