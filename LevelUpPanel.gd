extends Node2D

@onready var button = $BG/Button

@onready var powerUpHeader1 = $BG/PowerUpHeader1
@onready var powerUpDescription1 = $BG/PowerUp1Container/PowerUp1Description
@onready var powerUpHeader2 = $BG/PowerUpHeader2
@onready var powerUpDescription2 = $BG/PowerUp2Container/PowerUp2Description
@onready var powerUpHeader3 = $BG/PowerUpHeader3
@onready var powerUpDescription3 = $BG/PowerUp3Container/PowerUp3Description
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _levelUpPanelOpened(powerUpIndex1, powerUpIndex2, powerUpIndex3):
	match powerUpIndex1:
		0:
			powerUpHeader1.text = "Increased hops"
			powerUpDescription1.text = "Increases your maximum jumps by 1"
			pass
		1:
			powerUpHeader1.text = "Yeezys"
			powerUpDescription1.text = "Increases your movement speed"
			pass
		2:
			powerUpHeader1.text = "Better glock"
			powerUpDescription1.text = "Increases your reload speed, allowing you to fire faster"
			pass
	match powerUpIndex2:
		0:
			powerUpHeader2.text = "Increased hops"
			powerUpDescription2.text = "Increases your maximum jumps by 1"
			pass
		1:
			powerUpHeader2.text = "Yeezys"
			powerUpDescription2.text = "Increases your movement speed"
			pass
		2:
			powerUpHeader2.text = "Better glock"
			powerUpDescription2.text = "Increases your reload speed, allowing you to fire faster"
			pass
	match powerUpIndex3:
		0:
			powerUpHeader3.text = "Increased hops"
			powerUpDescription3.text = "Increases your maximum jumps by 1"
			pass
		1:
			powerUpHeader3.text = "Yeezys"
			powerUpDescription3.text = "Increases your movement speed"
			pass
		2:
			powerUpHeader3.text = "Better glock"
			powerUpDescription3.text = "Increases your reload speed, allowing you to fire faster"
			pass
			
	button.grab_focus()
