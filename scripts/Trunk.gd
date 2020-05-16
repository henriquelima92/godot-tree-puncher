extends Node2D

onready var sprite = $sprite
onready var left_axe = $leftAxe
onready var right_axe = $rightAxe
onready var timer = $timer


var sprite_height
var speed = 1000
var direction = 1

func _ready():
#	initialize(true)
	sprite_height = sprite.texture.get_height() * scale.y
	
	set_process(false)
	
func _process(delta):
	position.x += speed * direction * delta
	
func initialize(hasAxe):
	if hasAxe == true:
		var side = round(rand_range(0,100))
		if side >= 0 && side <= 50: #right
			left_axe.queue_free()
		else: #left
			right_axe.queue_free()
	else:
		left_axe.queue_free()
		right_axe.queue_free()
		
func remove(from_right):
	if from_right == true:
		direction = -1
	else:
		direction = 1
	timer.start()
	set_process(true)
	






func _on_timer_timeout():
	queue_free()
