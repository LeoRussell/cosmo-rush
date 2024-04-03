extends Node2D


var _enemies_number = 0


func _physics_process(delta):
	if _enemies_number == 0:
		_enemies_number = -1
		$WaveDelay.start()
		
		
func _scenario_load(scenario):
	if scenario == 1:
		_scenario_1()
	
	elif scenario == 2:
		_scenario_2()
		
	elif scenario == 3:
		_scenario_3()
		
func _on_wave_delay_timeout():
	var rng = RandomNumberGenerator.new()
	var scenario = rng.randi_range(1, 3)
	
	_scenario_load(scenario)
	_enemies_number += 1
	
	
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

func _scenario_2():
	for mult in range(0, 5):
		var _preload = preload("res://scenes/lightenemy.tscn")
		var enemy = _preload.instantiate()
		enemy.name = "EnemyLight" + str(mult)
		
		_enemies_number += 1
		
		get_parent().add_child(enemy)
		enemy.position.y = -70
		enemy.position.x = 5 + (100 * mult)
		enemy.set_movement(10)
		
		
func _scenario_3():
	for mult in range(0, 5):
		var _preload = preload("res://scenes/poorenemy.tscn")
		var enemy = _preload.instantiate()
		enemy.name = "EnemyPoor" + str(mult)
		
		_enemies_number += 1
		
		get_parent().add_child(enemy)
		enemy.position.y = -50
		enemy.position.x = 5 + (100 * mult)
		enemy.set_movement(65)
	
	for mult in range(0, 5):
		var _preload = preload("res://scenes/lightenemy.tscn")
		var enemy = _preload.instantiate()
		enemy.name = "EnemyLight" + str(mult)
		
		_enemies_number += 1
		
		get_parent().add_child(enemy)
		enemy.position.y = -110
		enemy.position.x = 5 + (100 * mult)
		enemy.set_movement(10)
