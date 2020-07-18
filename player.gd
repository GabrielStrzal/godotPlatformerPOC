extends KinematicBody2D

const UP = Vector2(0, -1) #indicator for
const GRAVITY = 20
const SPEED = 400
const JUMP_HEIGHT = -650
var motion = Vector2()

var isAttacking = false;


func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right") && isAttacking == false:
		motion.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("run")
		$AttackArea.set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("ui_left") && isAttacking == false:
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("run")
		$AttackArea.set_scale(Vector2(-1, 1))
	
	else:
		motion.x = 0;
		if isAttacking == false:
			$Sprite.play("idle")

	if Input.is_action_pressed("attack"):
		$AttackArea/CollisionShape2D.disabled = false
		$Sprite.play("slash")
		isAttacking = true;	
	
	if is_on_floor():
		#motion.y = 0
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("jump")
	
	motion = move_and_slide(motion, UP)
	
	pass


func _on_Sprite_animation_finished():
	if $Sprite.animation == "slash":
		$AttackArea/CollisionShape2D.disabled = true;
		isAttacking = false;
