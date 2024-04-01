extends Node2D


var rng = RandomNumberGenerator.new()
var _enemies_number = 0


func _process(delta):
	if _enemies_number <= 0:
		var scenario = rng.randf_range(1.0, 1.0)
		
		if scenario == 1:
			_scenario_1()
			
			
func _scenario_1():
	for mult in range(0, 5):
		var _preload = preload("res://scenes/poorenemy.tscn")
		var enemy = _preload.instantiate()
		enemy.name = "EnemyPoor" + str(mult)
		
		_enemies_number += 1
		
		get_parent().add_child(enemy)
		enemy.position.y = -50
		enemy.position.x = 5 + (100 * mult)
		enemy.set_movement(10)
