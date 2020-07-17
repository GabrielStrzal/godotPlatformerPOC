extends Area2D

var dead = false;
var enemyLife = 3;

func _ready():
	pass;
	
func _process(delta):
	if dead == false:
		$AnimatedSprite.play("idle")
	if enemyLife <= 0:
		queue_free();



func _on_enemy_area_entered(area):
	if area.is_in_group("attack"):
		dead = true;
		enemyLife = enemyLife - 1;
