extends Node

var time_elapsed = 0
var timer_lap = Timer.new()
var timer_hide_message = Timer.new()

func _ready():
	get_node("Restart").hide()
	timer_lap.connect("timeout",self,"finish_lap")
	timer_lap.wait_time = 60
	timer_lap.one_shot = false
	add_child(timer_lap)
	timer_lap.start()
	timer_hide_message.connect("timeout",self,"hide_message")
	timer_hide_message.wait_time = 10
	timer_hide_message.one_shot = true
	add_child(timer_hide_message)

func hide_message():
	get_node("Message").text = ""

func finish_lap():
	get_node("Rival").max_velocity += 50
	if get_node("Player").position.x > get_node("Rival").position.x:
		get_node("Message").text = "You won"
		timer_hide_message.start()
		var window = JavaScript.get_interface("window")
		window.parent.postMessage(1)
	else:
		get_node("Message").text = "You lost"
		get_node("Restart").show()
		get_tree().paused = true
