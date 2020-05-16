extends Node

export(PackedScene) var trunk_scene

onready var first_trunk_position = $"FirstTrunkPosition"
onready var time_left = $TimeLeft
onready var player = $Player
onready var grave = $Grave
onready var timer = $Timer

var last_spaw
var timerDelta = 5
var timerIncreaser
var dead = false


var trunks = []

func _ready():
	_spawn_first_trucks()
	#pass # Replace with function body.
	
func _process(delta):
	if dead == false:
		_decreaseTimer(delta)
	
func _spawn_first_trucks():
	for i in range(0,6):
		_addTrunk(false)
		
	print(trunks.size())
func _decreaseTimer(delta):
	timerDelta -= delta
	time_left.set_value(timerDelta)
	if time_left.value <= 0:
		die()
		
func _increaseTimer(value):
	time_left.value += value
	
	
func _addTrunk(hasAxes):
	var new_trunk = trunk_scene.instance()
	add_child(new_trunk)
	new_trunk.position.x = first_trunk_position.position.x
	new_trunk.position.y = first_trunk_position.position.y - (new_trunk.sprite_height*trunks.size())
	new_trunk.initialize(hasAxes)
	trunks.append(new_trunk)
	
func punch_tree(from_right):
	trunks[0].remove(from_right)
	trunks.pop_front()
	for trunk in trunks:
		trunk.position.y += trunk.sprite_height
	_addTrunk(true)
	_increaseTimer(2)
	
func die():
	grave.position.x = player.position.x
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true
	
	
func _on_Timer_timeout():
	get_tree().reload_current_scene()
