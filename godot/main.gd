extends Node

export (PackedScene) var Egg

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var eggNum = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	add_to_group("eggs")
	move_chicken()
	$chicken.connect("on_move_ready", self, "move_chicken")
	$down_egg.connect("finished", self, "down_egg_finish")

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_SPACE:
					# Only first down can be active.
					if not event.echo:
						lay_eggs()
				KEY_ESCAPE:
					get_tree().quit()
					
func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if not event.pressed:
			lay_eggs()

func move_chicken():
	var pos = get_rand_pos($chicken.Fix_x, $chicken.Fix_y)
	$chicken.move_to(pos)
	
func down_egg_finish():
	$down_egg.stop()
	
func lay_eggs():
	var egg = Egg.instance()
	egg.position = $chicken.position
	add_child(egg)
	eggNum += 1
	$down_egg.play()
	$HUD/num_label.text = "%0*d" % [3, eggNum]
	
func get_rand_pos(fix_x, fix_y):
	var wsize = get_viewport().size
	var pos = Vector2(randi() % int(wsize.x), randi() % int(wsize.y))
	if pos.x < fix_x:
		pos.x = fix_x
	elif pos.x > wsize.x - fix_x:
		pos.x = wsize.x - fix_x
		
	if pos.y < fix_y:
		pos.y = fix_y
	elif pos.y > wsize.y - fix_y:
		pos.y = wsize.y - fix_y
		
	return Vector2(pos.x, pos.y)
	#print("lay egg!")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
