extends Control


func _input(event): 
	if event.as_text().to_upper() == "SPACE":
		queue_free()
		
	elif event.as_text().to_upper() == "ESCAPE":
		get_tree().quit()
	
