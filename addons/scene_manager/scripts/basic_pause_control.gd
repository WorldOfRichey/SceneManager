extends PauseScreen

@onready var control : Control = get_node("Control")
@onready var panel : Panel = get_node("Control/Panel")

func _show_pause_screen() -> void:
	control.visible = true
	control.modulate = Color(1, 1, 1, 0)
	
	var end_pos = panel.position
	panel.position.y = panel.position.y + 30
	
	var motion_tween : Tween = create_tween()
	motion_tween.set_trans(Tween.TRANS_EXPO)
	motion_tween.tween_property(panel, "position", end_pos, 0.1)
	motion_tween.play()
	
	var alpha_tween : Tween = create_tween()
	alpha_tween.set_trans(Tween.TRANS_LINEAR)
	alpha_tween.tween_property(control, "modulate", Color(1,1,1,1), 0.1)
	
	
func _hide_pause_screen() -> void:
	control.visible = false

func _on_resume_pressed():
	SceneManager.resume_game()

func _on_quit_pressed():
	SceneManager.quit_game()
