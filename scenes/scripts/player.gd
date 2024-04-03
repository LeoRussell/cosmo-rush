extends CharacterBody2D

@export var projectile : PackedScene
@onready var _animated_sprite = $PlayerSprite
@onready var _marker = $ProjectileMarker

var can_shoot = true

var _health = 3
var speed = 250	

func _physics_process(delta):
	if _health > 0:
		if Input.is_action_pressed("fire_up"):
			if can_shoot == true:
				shoot()
				
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * speed
		move_and_slide()
		
		if Input.is_action_pressed("move_left"):
			_animated_sprite.play("move_left")
			
		elif Input.is_action_pressed("move_right"):
			_animated_sprite.play("move_right")	
			
		elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			_animated_sprite.play("move")
			
			
		else:
			_animated_sprite.play("idle")
		
		
func get_damage(value):
	_health -= value
	
	if _health <= 0:
		$PlayerColliderUpper.queue_free()
		$PlayerColliderBottom.queue_free()
		
		_animated_sprite.play("death")
		$DeathSound.play()
		
	else:
		$HitSound.play()
		
		
func shoot():
	can_shoot = false
	$ShootingTimer.start()
	$ShootingSound.play()
		
	var pr1 = projectile.instantiate()
	#var pr2 = projectile.instantiate()
	
	get_parent().add_child(pr1)
	#pr1.position.x = _marker.global_position.x - 10
	pr1.position.x = _marker.global_position.x - 43
	pr1.position.y = _marker.global_position.y - 80
	
	#get_parent().add_child(pr2)
	#pr2.position.x = _marker.global_position.x + 35
	#pr2.position.y = _marker.global_position.y
	
	
func _on_death_sound_finished():
	queue_free()
	
	
func _on_shooting_timer_timeout():
	can_shoot = true
