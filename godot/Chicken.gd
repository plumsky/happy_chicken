extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var Fix_x = 32
export var Fix_y = 36
export var speed = 200

signal on_move_ready

var target = Vector2()
var velocity = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func move_to(pos):
	target = pos
	if position.x > target.x:
		$Sprite.flip_h = false
	elif position.x < target.x:
		$Sprite.flip_h = true
	
func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		move_and_slide(velocity)
	else:
		emit_signal("on_move_ready")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
