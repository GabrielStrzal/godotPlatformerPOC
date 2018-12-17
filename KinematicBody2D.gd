extends KinematicBody2D

const UP = Vector2(0, -1) #indicator for
const GRAVITY = 20
const SPEED = 400
const JUMP_HEIGHT = -650
var motion = Vector2()


func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("run")
	else:
		motion.x = 0
		$Sprite.play("idle")
	
	if is_on_floor():
		#motion.y = 0
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("jump")
	
	motion = move_and_slide(motion, UP)
	
	pass
