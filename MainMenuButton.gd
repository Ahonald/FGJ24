extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://gameplay.tscn") # Replace with function body.
