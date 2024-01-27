extends CharacterBody2D

const JUMP_VELOCITY = -250.0
const JumpXVelocity = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer") 

var playerDamage = 5

var health = 10

var playerIsNear
var canSeePlayer
var player
var jumpSide
var jumpCD = 0
var die = false
var detectionArea
var detectionCollision
var collision

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player"
	detectionArea = $DetectionArea/CollisionShape2D
	collision = $CollisionShape2D
	detectionCollision =  $DetectionArea/CollisionShape2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		die = true
	if(die):
		detectionArea.set_process(false)
		collision.disabled = true
		detectionCollision.set_process(false)
		anim.play("Die")
		velocity.y = 0
		velocity.x = 0
		await get_tree().create_timer(0.8).timeout
		queue_free()
	else:
			
		if(jumpCD >= 0):
			jumpCD -= delta
			
		if(player.global_position.x > global_position.x):
			jumpSide = 1
		else:
			jumpSide = -1
		var space_state = get_world_2d().direct_space_state
		
		if not is_on_floor():
			velocity.y += gravity * delta
			velocity.x = JumpXVelocity * jumpSide
		else:
			velocity.x = 0

		
		move_and_slide()
		anim.play("Jump")
		if(playerIsNear):
			var visionQuery = PhysicsRayQueryParameters2D.create(global_position, player.position)
			visionQuery.exclude = [self]
			var result = space_state.intersect_ray(visionQuery)
			if(result.size() > 0):
				if(result.collider.name == "Player"):
					canSeePlayer = true
				else:
					canSeePlayer = false
					
		if(playerIsNear && canSeePlayer && is_on_floor() && jumpCD <= 0):
			jumpCD = 3
			anim.play("Jump")
			velocity.y = JUMP_VELOCITY

		
func _on_detection_area_body_entered(body):
	if(body.name == "Player"):
		playerIsNear = true

func _on_detection_area_body_exited(body):
	if(body.name == "Player"):
		playerIsNear = false
		canSeePlayer = false
		
func _takeDamage(dmg = 5):
	health-=5
