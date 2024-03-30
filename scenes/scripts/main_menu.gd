extends Control

@export_file("*.tscn") var _game

func _input(event): 
	if event.as_text().to_upper() == "SPACE":
		get_tree().change_scene_to_file(_game) 
		
	elif event.as_text().to_upper() == "ESCAPE":
		get_tree().quit()
