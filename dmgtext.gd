extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func displayDmgText(dmg = 5):
	text = "-" + str(dmg)
	visible = true
	await get_tree().create_timer(0.2).timeout
	visible = false
