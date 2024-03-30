extends CharacterBody2D

@export var projectile : PackedScene
@onready var _animated_sprite = $PlayerSprite
var can_shoot = true

const SPEED = 175	

func _physics_process(delta):
	if Input.is_action_pressed("fire_up") or Input.is_action_pressed("fire_down"):
		if can_shoot == true:
			shoot()
			
			
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if Input.is_action_pressed("move_left"):
		_animated_sprite.play("move_left")
		
	elif Input.is_action_pressed("move_right"):
		_animated_sprite.play("move_right")
		
	elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		_animated_sprite.play("idle")
		
	else:
		_animated_sprite.play("idle")
		
		
func shoot():
	can_shoot = false
	$ShootingTimer.start()
	
	var pr = projectile.instantiate()
	
	get_parent().add_child(pr)
	pr.position = $ProjectileMarker.global_position
	

func _on_timer_timeout():
	can_shoot = true
