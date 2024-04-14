extends CharacterBody2D

@export var projectile : PackedScene
@onready var _animated_sprite = $PlayerSprite
@onready var _marker = $ProjectileMarker

var can_shoot = true
var can_dash = true
var is_Invulnerable = false

var _current_mode = ("SINGLE")
var _level = 1

var _health = 3
var _current_speed = 250
var _modi_speed = 250

func _physics_process(delta):
	if _health > 0:
		if Input.is_action_just_pressed("dash"):
			if can_dash == true:
				is_Invulnerable = true
				_current_speed = _modi_speed * 2
				
				can_dash = false
				$DashTimer.start()
				
			else:
				pass
		
		if Input.is_action_pressed("fire_up"):
			if can_shoot == true:
				shoot(_level)
				
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * _current_speed
		move_and_slide()
		
		if Input.is_action_pressed("move_left"):
			_animated_sprite.play("move_left")
			
		elif Input.is_action_pressed("move_right"):
			_animated_sprite.play("move_right")	
			
		elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
			_animated_sprite.play("move")
			
			
		else:
			_animated_sprite.play("idle")
			
			
func _on_signal_body_body_entered(body):
	if body.name.begins_with("PickupBuff"):
		_current_mode = body._modificator
		$BuffTimer.start()
	
	elif body.name.begins_with("PickupOneUp"):
		print("level +1")
		if _level < 15:
			_level += 1
			print(_level)
	
	body.pickup()
	$PickupSound.play()
			
			
func get_damage(value):
	if is_Invulnerable == false:
		_health -= value
		
		if _health <= 0:
			$PlayerColliderUpper.queue_free()
			$PlayerColliderBottom.queue_free()
			
			_animated_sprite.play("death")
			$DeathSound.play()
			
		else:
			$HitSound.play()
		
		
func shoot(level):
	can_shoot = false
	$ShootingTimer.start()
	$ShootingSound.play()
	
	if _current_mode == ("SINGLE"):
		var pr = projectile.instantiate()
		get_parent().add_child(pr)
		pr.power = _level
		
		pr.position.x = _marker.global_position.x - 43
		pr.position.y = _marker.global_position.y - 80
	
	elif _current_mode == ("DOUBLE"):
		var pr1 = projectile.instantiate()
		var pr2 = projectile.instantiate()
		
		pr1.power = _level
		pr2.power = _level
		
		get_parent().add_child(pr1)
		pr1.position.x = _marker.global_position.x - 69
		pr1.position.y = _marker.global_position.y - 80
		
		get_parent().add_child(pr2)
		pr2.position.x = _marker.global_position.x - 16
		pr2.position.y = _marker.global_position.y - 80
	
	
func _on_death_sound_finished():
	queue_free()
	
	
func _on_dash_timer_timeout():
	_current_speed = _modi_speed
	is_Invulnerable = false
	$DashCooldown.start()
	
	
func _on_shooting_timer_timeout():
	can_shoot = true


func _on_buff_timer_timeout():
	_current_mode = ("SINGLE")


func _on_dash_cooldown_timeout():
	can_dash = true
