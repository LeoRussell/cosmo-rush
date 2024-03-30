extends CharacterBody2D

@onready var _animated_sprite = $BulletSprite

@onready var direction = Input.get_vector("blank", "blank", "fire_up", "blank")
const SPEED = 350


func _on_ready():
	_animated_sprite.play("idle")

func _physics_process(delta):
	velocity = direction * SPEED
	
	move_and_slide()


func _on_bullet_signal_body_entered(body):
	print(body.name)
	if body.name.begins_with("BorderCollider"):
		body.queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()
