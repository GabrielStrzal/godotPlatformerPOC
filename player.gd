extends CharacterBody2D

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
		$Sprite2D.flip_h = false
		$Sprite2D.play("run")
		$AttackArea.set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("ui_left") && isAttacking == false:
		motion.x = -SPEED
		$Sprite2D.flip_h = true
		$Sprite2D.play("run")
		$AttackArea.set_scale(Vector2(-1, 1))
	
	else:
		motion.x = 0;
		if isAttacking == false:
			$Sprite2D.play("idle")
		
	
	if is_on_floor():
		if Input.is_action_just_pressed("attack"):
			print("Attack pressed")
			$AttackArea/CollisionShape2D.disabled = false
			isAttacking = true;	
			$Sprite2D.play("slash")
		
		#motion.y = 0
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite2D.play("jump")
	
	set_velocity(motion)
	set_up_direction(UP)
	move_and_slide()
	motion = velocity
	
	pass


func _on_Sprite_animation_finished():
	if $Sprite2D.animation == "slash":
		print("Attack animation finished")
		$AttackArea/CollisionShape2D.disabled = true;
		isAttacking = false;
