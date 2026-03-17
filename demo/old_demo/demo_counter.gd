extends Label

var count : float = 0

func _process(delta):
	count = count + delta
	text = "%f" % count
