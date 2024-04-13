extends CharacterBody2D

@onready var _animated_sprite = $BulletSprite

var direction = Input.get_vector("blank", "blank", "fire_up", "blank")
var _self_speed = 450


func _physics_process(delta):
	velocity = direction * _self_speed
	
	move_and_slide()


func set_power(level):
	var string_ = "BulletSignal/Level{level}SignalCollider"
	get_node(string_.format({"level":str(level)})).disabled = false
	_self_speed = 250 + 5/level * 50 + level * 50
	
	
func _on_bullet_signal_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.get_damage(ceil(($"../Player"._level)/3 + 0.25))
		queue_free()
	
	
func _on_visible_notifier_screen_exited():
	queue_free()
