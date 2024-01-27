extends Node2D

@onready var button = $BG/Button

@onready var powerUpHeader1 = $BG/PowerUpHeader1
@onready var powerUpDescription1 = $BG/PowerUp1Container/PowerUp1Description
@onready var powerUpHeader2 = $BG/PowerUpHeader2
@onready var powerUpDescription2 = $BG/PowerUp2Container/PowerUp2Description
@onready var powerUpHeader3 = $BG/PowerUpHeader3
@onready var powerUpDescription3 = $BG/PowerUp3Container/PowerUp3Description

@onready var Button1 = $BG/Button
@onready var Button2 = $BG/Button2
@onready var Button3 = $BG/Button3

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
		3:
			powerUpHeader1.text = "Revitalizingly shitty joke"
			powerUpDescription1.text = "Heals you to full HP and increases your maximum HP"
			pass
		4:
			powerUpHeader1.text = "Big gun"
			powerUpDescription1.text = "Increases the amount of bullet you can fire at once"
			pass
		5: 
			powerUpHeader1.text = "Pun-laced bullets"
			powerUpDescription1.text = "Increases the amount of damage your funny ass bullets do"
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
		3:
			powerUpHeader2.text = "Revitalizingly shitty joke"
			powerUpDescription2.text = "Heals you to full HP and increases your maximum HP"
			pass
		4:
			powerUpHeader2.text = "Big gun"
			powerUpDescription2.text = "Increases the amount of bullet you can fire at once"
			pass
		5: 
			powerUpHeader2.text = "Pun-laced bullets"
			powerUpDescription2.text = "Increases the amount of damage your funny ass bullets do"
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
		3:
			powerUpHeader3.text = "Revitalizingly shitty joke"
			powerUpDescription3.text = "Heals you to full HP and increases your maximum HP"
			pass
		4:
			powerUpHeader3.text = "Big gun"
			powerUpDescription3.text = "Increases the amount of bullet you can fire at once"
			pass	
		5: 
			powerUpHeader3.text = "Pun-laced bullets"
			powerUpDescription3.text = "Increases the amount of damage your funny ass bullets do"
	Button1.powerUpIndex = powerUpIndex1
	Button2.powerUpIndex = powerUpIndex2
	Button3.powerUpIndex = powerUpIndex3
	
	button.grab_focus()
