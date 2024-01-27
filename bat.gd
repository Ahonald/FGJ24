extends CharacterBody2D


var playerIsNear
var canSeePlayer
var shootCoolDown = 0

var xDelta = 0
var yDelta = 0

@onready var gameplay = $".."
@onready var anim = get_node("AnimationPlayer") 
@onready var bullet = preload("res://enemy_bullet.tscn")
@onready var bulletPoint = $BulletSpawnPoint
@onready var bulletPoint2 = $BulletSpawnPoint2
@onready var bulletPoint3 = $BulletSpawnPoint3

@onready var player = $"../Player"

var die = false

func _physics_process(delta):
	
	if(!die):
		anim.play("Idle")
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
					
		if(shootCoolDown <= 0 && canSeePlayer):
			_shoot()
			shootCoolDown = 2
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
	newBullet.position.x = bulletPoint.global_position.x
	newBullet.position.y = bulletPoint.global_position.y
	newBullet.dirX = 0
	newBullet.dirY = 1
	
	newBullet = bullet.instantiate()
	gameplay.add_child(newBullet)
	newBullet.position.x = bulletPoint2.global_position.x
	newBullet.position.y = bulletPoint2.global_position.y
	newBullet.dirX = 0.5
	newBullet.dirY = 1

	newBullet = bullet.instantiate()
	gameplay.add_child(newBullet)
	newBullet.position.x = bulletPoint3.global_position.x
	newBullet.position.y = bulletPoint3.global_position.y
	newBullet.dirX = -0.5
	newBullet.dirY = 1

func _on_hit_box_body_entered(body):
	print(body)

func _on_hit_box_area_entered(area):
	if(area.get_parent().get_name() == "PlayerBullet"):
		die = true # Replace with function body.
