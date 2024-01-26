extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer") 


var playerIsNear
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var space_state = get_world_2d().direct_space_state
	if not is_on_floor():
		velocity.y += gravity * delta
	anim.play("Jump")
	move_and_slide()
	if(playerIsNear):
		var visionQuery = PhysicsRayQueryParameters2D.create(global_position, player.position)
		visionQuery.exclude = [self]

		var result = space_state.intersect_ray(visionQuery)
		if(result.size() > 0):
			print("oof")
			print(result.values())
			if(result.values().has("Player")):
				print("EEP!")


func _on_detection_area_body_entered(body):
	if(body.name == "Player"):
		playerIsNear = true


func _on_detection_area_body_exited(body):
	if(body.name == "Player"):
		playerIsNear = false
