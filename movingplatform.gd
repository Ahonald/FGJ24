extends CharacterBody2D

@export var moveLength : int = 100
@export var movementSpeed : int = 50
var startPoint
var distTravelled = 0
var goingForward = true
# Called when the node enters the scene tree for the first time.
func _ready():
	startPoint = global_position.y # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var travel = delta*movementSpeed
	if(goingForward == true):
		global_position.y += travel
		distTravelled+= travel
		if(distTravelled > moveLength):
			distTravelled = 0
			goingForward = false
	else:
		global_position.y-= travel
		distTravelled+= travel
		if(distTravelled > moveLength):
			distTravelled = 0
			goingForward = true
	
