extends CharacterBody2D


@onready var _player = $"../Player"
@onready var _animated_sprite = $EnemySprite

var _speed = 50
var _health = 3

var is_moving = false
var _posrow = 0

func _on_ready():
	$ActivationTimer.start()
	
	
func _on_activation_timer_timeout():
	set_movement(1000, 100)
	
	
func set_movement(pos, speed=50):
	if global_position.y < pos:
		_posrow = pos
		is_moving = true
		
		_animated_sprite.play("move")
	
	else:
		is_moving = false
	
	_speed = speed
	
func _physics_process(delta):
	if is_moving == true:
		if global_position.y < _posrow:
			var direction = Vector2(0, 1)
			velocity = direction * _speed
			move_and_slide()
			
		else:
			is_moving = false
			_animated_sprite.play("idle")
			
			
func _on_interaction_signal_body_entered(body):
	if body.name.begins_with("Player"):
		body.get_damage(1)
	
	
func get_damage(value):
	_health -= value
	
	if _health <= 0:
		set_movement(0, 0)
		$EnemyCollision.queue_free()
		
		_animated_sprite.play("death")
		$DeathSound.play()
		
	else:
		$HitSound.play()


func _on_death_sound_finished():
	$"../Game"._enemies_number -= 1
	queue_free()


func _on_visible_notifier_screen_exited():
	$"../Game"._enemies_number -= 1
	queue_free()
	
