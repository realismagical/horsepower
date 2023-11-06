extends ParallaxBackground

var velocity = 0

func _process(delta):
	$ParallaxLayer.motion_offset += Vector2.LEFT * velocity * delta
