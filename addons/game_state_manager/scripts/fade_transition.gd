extends SceneTransition

@onready var color_rect : ColorRect = get_node("ColorRect")

var tween : Tween

func scene_loaded_update(percentage : float ) -> void :
	print (percentage)

func _trigger_transition_in() -> void:
	GameManager.scene_loader.signal_scene_loading.connect(scene_loaded_update)
	color_rect.color = Color(0,0,0,0)
	color_rect.visible = true
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "color", Color(0,0,0,1), 0.5)
	tween.tween_callback(trigger_transition_in_complete)
	tween.play()
	
	super._trigger_transition_in()

func trigger_transition_in_complete() -> void :
	tween = null
	self.signal_in_transition_ended.emit()

func _trigger_transition_out() -> void:
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "color", Color(0,0,0,0), 0.5)
	tween.tween_callback(trigger_transition_out_complete)
	tween.play()
	super._trigger_transition_out()
	
func trigger_transition_out_complete() -> void :
	tween = null
	color_rect.visible = false
	self.signal_out_transition_ended.emit()
	GameManager.scene_loader.signal_scene_loading.disconnect(scene_loaded_update)
