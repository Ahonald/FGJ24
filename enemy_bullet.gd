extends Node2D

var dirX = -1
var dirY = 1

var MaxSpeed = 50
const MaxDistance = 200
var travelledDistance = 0
var die = false
@onready var anim = get_node("AnimationPlayer") 

var playerPos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!die):
		anim.play("Exist")
		var travel = MaxSpeed*delta
		position.x += travel * dirX
		position.y += travel * dirY	
		travelledDistance += travel
	if(travelledDistance > MaxDistance || die):
		die = true
		anim.play("Explode")
		await get_tree().create_timer(0.6).timeout
		queue_free()


func _on_enemy_bullet_area_body_entered(body):
	if(!body.name.contains("Bat")):
		anim.play("Explode")
		await get_tree().create_timer(0.6).timeout
		queue_free() # Replace with function body.
