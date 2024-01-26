extends Node2D

var speed = 500
const MaxDistance = 500
var travelledDistance = 0
var isMovingRight = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var player =  $"../Player"# Replace with function body.
	if(player.isPointingRight):
		isMovingRight = true
	else:
		isMovingRight = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isMovingRight:
		var travel = speed*delta
		position.x += travel
		travelledDistance += travel
		if(travelledDistance > MaxDistance):
			queue_free()
	else:
		var travel = speed*delta
		position.x -= travel
		travelledDistance += travel
		if(travelledDistance > MaxDistance):
			queue_free()


func _on_area_2d_body_entered(body):
	if(body.name != "Player"):
		queue_free() # Replace with function body.
