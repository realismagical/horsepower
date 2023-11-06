extends Area2D

var speed = 0
var brio = 0
var faster = true
var player_velocity
var max_velocity = 300

func _ready():
	randomize()
	brio = rand_range(1,100)

func min_int(a,b):
	if a < b:
		return a
	return b

func _process(delta):
	player_velocity = get_parent().get_node("ParallaxBackground").velocity
	if brio > 0:
		if faster or get_parent().get_node("ParallaxBackground").velocity == 0:
			speed = rand_range(50,max_velocity)
			player_velocity = rand_range(0,min_int(max_velocity-50,player_velocity))
			if player_velocity < speed:
				speed -= player_velocity
		else:
			speed = rand_range(-300,-50)
	else:
		brio = rand_range(1,100)
		faster = not faster
	var velocity = Vector2.ZERO
	velocity.x += 1
	$AnimatedSprite.play()
	position += velocity * delta * speed
	brio -= 1
