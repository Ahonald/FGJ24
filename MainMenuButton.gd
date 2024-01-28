extends Button

@onready var buttonNoise = get_node("ButtonNoise")

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_pressed():
	get_tree().change_scene_to_file("res://gameplay.tscn") # Replace with function body.





func _on_focus_exited():
	pass # Replace with function body.
	buttonNoise.play()
	


func _on_focus_entered():
	pass # Replace with function body.
	buttonNoise.play()
