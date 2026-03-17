extends Node3D

var tween : Tween
var start_pos : Vector3
var end_pos : Vector3

func _ready():
	start_pos = position
	end_pos = position
	end_pos.y = 1
	
	start_move_up.call_deferred()

func start_move_up() -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "position", end_pos, 0.5)
	tween.tween_callback(start_move_down)
	tween.play()
	
func start_move_down() -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "position", start_pos, 0.5)
	tween.tween_callback(start_move_up)
	tween.play()
