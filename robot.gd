extends CharacterBody2D

var health = 20
var die = false

var playerIsNear
var canSeePlayer
var shootCoolDown = 0
@onready var player = $"../Player"
@onready var bulletPoint = $BulletSpawnPoint
@onready var bulletPoint2 = $BulletSpawnPoint2
@onready var anim = get_node("AnimationPlayer") 
@onready var bullet = preload("res://enemy_bullet_redbullet.tscn")
@onready var gameplay = $".."

var bulletDir = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !die:
		if(shootCoolDown >= 0):
			shootCoolDown-= delta
				
		var space_state = get_world_2d().direct_space_state
		
		if(playerIsNear):		
			var visionQuery = PhysicsRayQueryParameters2D.create(global_position, player.position)
			visionQuery.exclude = [self]
			var result = space_state.intersect_ray(visionQuery)
			if(result.size() > 0):
				if(result.collider.name == "Player"):
					canSeePlayer = true
				else:
					canSeePlayer = false
		if(canSeePlayer):
			if(player.global_position.x > global_position.x):
				bulletDir = 1
				get_node("AnimatedSprite2D").flip_h = false
			else:
				bulletDir = -1
				get_node("AnimatedSprite2D").flip_h = true
				
		if(shootCoolDown <= 0 && canSeePlayer):
			_shoot()
			shootCoolDown = 2
		if(health<=0):
			die =true
	else:
		queue_free()
		
func _on_detection_area_body_entered(body):
	if(body.name == "Player"):
		playerIsNear = true


func _on_detection_area_body_exited(body):
	if(body.name == "Player"):
		playerIsNear = false
		canSeePlayer = false
		
func _shoot():		
	var newBullet = bullet.instantiate()
	gameplay.add_child(newBullet)
	bulletPoint2
	newBullet.dirX = bulletDir
	newBullet.dirY = 0
	newBullet.MaxSpeed = 200
	newBullet.MaxDistance = 2000
	newBullet.hasdeathAnim = false
	newBullet.position.x = bulletPoint.global_position.x if bulletDir == 1 else bulletPoint2.global_position.x
	newBullet.position.y = bulletPoint.global_position.y if bulletDir == 1 else bulletPoint2.global_position.y
	anim.play("shoot")

func _takeDamage(dmg = 5):
	health-=5
