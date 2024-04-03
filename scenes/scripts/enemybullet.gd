extends CharacterBody2D

@onready var _animated_sprite = $EnemyBulletSprite

var direction = Vector2(0, 1)
const SPEED = 150


func _physics_process(delta):
	velocity = direction * SPEED
	
	move_and_slide()

	
func _on_bullet_signal_body_entered(body):
	if body.name.begins_with("Player"):
		body.get_damage(1)
		queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()
