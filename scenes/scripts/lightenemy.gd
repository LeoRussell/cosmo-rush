extends CharacterBody2D


var _pickup_preload = ("BLANK")
@export var projectile : PackedScene
@onready var _animated_sprite = $EnemySprite
@onready var _marker = $ProjectileMarker
var rng = RandomNumberGenerator.new()

var _speed = 30
var _health = 3

var is_moving = false
var _posrow = 0
var is_attacking = false

var can_attack = false

func _on_ready():
	$ActivationTimer.start()
	
	
func _on_activation_timer_timeout():
	if _health > 0:
		set_movement(1000, 100)
		
func _create_pickup(numero):
	if numero == 1:
		_pickup_preload = preload("res://scenes/doublepickup.tscn")
	
	
	if typeof(_pickup_preload) != 4:
		var pickup = _pickup_preload.instantiate()
		pickup.name = "PickupBuff" + str(rng.randf_range(128, 0))
		get_parent().add_child(pickup)
		
		pickup.position.x = global_position.x + 50
		pickup.position.y = global_position.y + 60
		
	else:
		pass
		
		
func set_movement(pos, speed=50):
	if global_position.y < pos:
		_posrow = pos
		is_moving = true
		
		_animated_sprite.play("move") 
	
	else:
		is_moving = false
	
	_speed = speed
	
func _physics_process(delta):
	if _health > 0:
		if can_attack and is_attacking == false:
			shoot()
			is_attacking = true
			$ShootingTimer.start()
			
			
		if is_moving == true:
			if global_position.y < _posrow:
				var direction = Vector2(0, 1)
				velocity = direction * _speed
				move_and_slide()
				
			else:
				is_moving = false
				_animated_sprite.play("idle")
			
			
func shoot():
	var pr = projectile.instantiate()
	
	get_parent().add_child(pr)
	pr.position.x = _marker.global_position.x + 7
	pr.position.y = _marker.global_position.y + 30
	
	
func _on_interaction_signal_body_entered(body):
	if body.name.begins_with("Player"):
		body.get_damage(1)
	
	
func get_damage(value):
	_health -= value
	$HitSound.play()
	
	if _health <= 0:
		set_movement(0, 0)
		$EnemyCollision.queue_free()
		
		_animated_sprite.play("death")
		$DeathSound.play()
		
		var _numero = rng.randi_range(1, 5)
	
		_create_pickup(_numero)


func _on_death_sound_finished():
	$"../Game"._enemies_number -= 1
	queue_free()


func _on_visible_notifier_screen_exited():
	$"../Game"._enemies_number -= 1
	queue_free()


func _on_shooting_delay_timeout():
	can_attack = true
	
	
func _on_shooting_timer_timeout():
	is_attacking = false
