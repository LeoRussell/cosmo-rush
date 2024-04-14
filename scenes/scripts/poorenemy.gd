extends CharacterBody2D


var _pickup_preload = ("BLANK")
@onready var _animated_sprite = $EnemySprite
var rng = RandomNumberGenerator.new()

var _speed = 50
var _health = 3

var is_attacking = false
var is_moving = false
var _posrow = 0


func _on_ready():
	$ActivationTimer.start()
	
	
func _on_activation_timer_timeout():
	if _health > 0:
		is_attacking = true
		set_movement(1000, 100)
	
	
func set_movement(pos, speed=50):
	if global_position.y < pos:
		_posrow = pos
		is_moving = true
		
		if is_attacking:
			_animated_sprite.play("move") 
		else:
			_animated_sprite.play("idle")
	
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
		body.get_damage(2)
	
	
func get_damage(value):
	_health -= value
	$HitSound.play()
	
	if _health <= 0:
		set_movement(0, 0)
		$EnemyCollision.queue_free()
		
		_animated_sprite.play("death")
		$DeathSound.play()
		
		var _numero = rng.randi_range(1, 10)
		_create_pickup(_numero)
		
		
func _create_pickup(numero):
	if numero in [1, 5, 8]:
		_pickup_preload = preload("res://scenes/doublepickup.tscn")
	elif numero == 7:
		_pickup_preload = preload("res://scenes/oneuppickup.tscn")

	if typeof(_pickup_preload) != 4:
		var pickup = _pickup_preload.instantiate()
		if pickup.id_ in [1]:
			pickup.name = "PickupBuff" + str(rng.randf_range(128, 0))
			get_parent().add_child(pickup)
			
			pickup.position.x = global_position.x + 50
			pickup.position.y = global_position.y + 60
			
		elif pickup.id_ == 2:
			pickup.name = "PickupOneUp" + str(rng.randf_range(128, 0))
			get_parent().add_child(pickup)
			
			pickup.position.x = global_position.x + 50
			pickup.position.y = global_position.y + 60
	
	else:
		pass
	
func _on_death_sound_finished():
	$"../Game"._enemies_number -= 1
	
	queue_free()


func _on_visible_notifier_screen_exited():
	$"../Game"._enemies_number -= 1
	queue_free()
	
