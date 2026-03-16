extends Label

func _ready():
	start_tween.call_deferred()
	
func start_tween() -> void :
	var tween : Tween = create_tween()
	tween.tween_method(tween_method, 0, 100, 10)
	tween.tween_callback(start_tween)
	tween.play()
	
func tween_method(v : float) -> void :
	text = "%f" % v
