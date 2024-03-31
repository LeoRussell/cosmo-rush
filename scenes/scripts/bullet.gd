extends CharacterBody2D

@onready var _animated_sprite = $BulletSprite

@onready var direction = Input.get_vector("blank", "blank", "fire_up", "blank")
const SPEED = 300


func _physics_process(delta):
	velocity = direction * SPEED
	
	move_and_slide()

	
func _on_bullet_signal_body_entered(body):
	print(body.name)
	if body.name.begins_with("Enemy"):
		body.get_damage(1)
		queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()
