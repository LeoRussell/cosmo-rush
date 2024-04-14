extends CharacterBody2D

@onready var _animated_sprite = $BulletSprite

var direction = Input.get_vector("blank", "blank", "fire_up", "blank")
var _self_speed = 450
var power = 1
var _activated = false


func _physics_process(delta):
	velocity = direction * _self_speed
	
	move_and_slide()
	
	
func _on_bullet_signal_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.get_damage(ceil(($"../Player"._level)/5.1 + 0.01))
		queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()


func _process(delta):
	if _activated != true:
		var to_set = ceil(power / 3.1 + 0.01)
		var string_ = "BulletSignal/Level{to_set}SignalCollider"
		
		_animated_sprite.play(str(to_set))
		get_node(string_.format({"to_set":str(to_set)})).disabled = false
		_self_speed = 250 + 5/to_set * 50 + to_set * 50
		
		_activated = true
