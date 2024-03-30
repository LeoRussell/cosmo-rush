extends CharacterBody2D

@onready var _animated_sprite = $BallSprite

@onready var direction = Input.get_vector("fire_left", "fire_right", "fire_up", "fire_down")
const SPEED = 250


func _on_ready():
	_animated_sprite.play("idle")

func _physics_process(delta):
	velocity = direction * SPEED
	
	move_and_slide()


func _on_ball_signal_body_entered(body):
	print(body.name)
	
	if body.name.begins_with("Enemy"):
		body.queue_free()
		
	queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()
