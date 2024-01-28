extends Node2D

var speed = 1000
const MaxDistance = 500
var travelledDistance = 0
var isMovingRight = true
var dmgValue = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var player =  $"../Player"# Replace with function body.
	if(player.isPointingRight):
		isMovingRight = true
		get_node("Sprite2D").flip_h = false
	else:
		isMovingRight = false
		get_node("Sprite2D").flip_h = true

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
	if(body.name.contains("Enemy")):
		body._takeDamage(dmgValue)
	if(body.name != "Player"):
		queue_free() # Replace with function body.
