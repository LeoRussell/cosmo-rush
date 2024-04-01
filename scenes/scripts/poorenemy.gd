extends CharacterBody2D


@onready var _player = $"../Player"
@onready var _animated_sprite = $EnemySprite

const SPEED = 50
var _health = 3

var is_moving = false
var _posrow = 0

func _physics_process(delta):
	if is_moving == true:
		if global_position.y < _posrow:
			var direction = Vector2(0, 1)
			velocity = direction * SPEED
				
			move_and_slide()
		else:
			is_moving = false
			_animated_sprite.play("idle")
			
	
func get_damage(points):
	_health -= points
	
	if _health <= 0:
		_animated_sprite.play("death")
		$EnemyCollision.queue_free()
		$DeathSound.play()
	else:
		$HitSound.play()


func _on_death_sound_finished():
	queue_free()


func set_movement(pos):
	if global_position.y < pos:
		_posrow = pos
		is_moving = true
		
		_animated_sprite.play("move")
	
