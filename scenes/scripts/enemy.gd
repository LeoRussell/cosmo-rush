extends CharacterBody2D


@onready var _player = $"../Player"
@onready var _animated_sprite = $EnemySprite

var speed = 1
var _health = 3

	
func _physics_process(delta):
	#move(_player)
	pass


func get_damage(points):
	_health -= points
	if _health <= 0:
		$EnemyCollision.queue_free()
		$DeathSound.play()
	else:
		$HitSound.play()


func _on_death_sound_finished():
	queue_free()

#func move(target):
	#var playerPos = target.transform.origin
	#var direction = playerPos - global_position
	
	#if playerPos.distance_to(global_position) >= 150:
	#	direction = Vector2(0, 0)
	#	if speed != 0:
	#		_animated_sprite.play("idle") 
	#else:
	#	if speed != 0:ite.play("move")
	#velocity = direction * speed
	#move_and_slide()
