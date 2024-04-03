extends CharacterBody2D

@onready var _animated_sprite = $DoubleSprite

var direction = Vector2(0, 1)
const SPEED = 100


func _physics_process(delta):
	velocity = direction * SPEED
	
	move_and_slide()
	
func pickup():
	queue_free()


func _on_visible_notifier_screen_exited():
	queue_free()
