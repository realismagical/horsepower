extends Area2D

signal velocity_changed(velocity)

var idx
var volume
var footstep = false
var swing_phase = false
var silence_watchdog = 0
var velocity = 0
var time_elapsed = 0

func _ready():
	idx = AudioServer.get_bus_index("Record")

func _process(delta):
	time_elapsed = time_elapsed + delta
	var volume = AudioServer.get_bus_peak_volume_left_db(idx, 0)
	volume = clamp(db2linear(volume), 0.0, 1.0)
	if volume > 0.7 and swing_phase:
		velocity = velocity + 10 * time_elapsed
		get_parent().get_node("ParallaxBackground").velocity = velocity
		swing_phase = false
		silence_watchdog = 0
		$AnimatedSprite.play()
	if volume < 0.4:
		silence_watchdog = silence_watchdog + 1
		swing_phase = true
		if silence_watchdog >= 20:
			$AnimatedSprite.stop()
			get_parent().get_node("ParallaxBackground").velocity = 0
		if silence_watchdog >= 60:
			velocity = 0
			time_elapsed = 0
