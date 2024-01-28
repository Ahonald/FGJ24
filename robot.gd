extends CharacterBody2D

@export var health :int  = 20
var die = false
@export var xpValue :int = 10
@export var bulletDmg: int = 5
var dmg = 5
var playerIsNear
var canSeePlayer
var shootCoolDown = 0
@onready var player = $"../Player"
@onready var bulletPoint = $BulletSpawnPoint
@onready var bulletPoint2 = $BulletSpawnPoint2
@onready var anim = get_node("AnimationPlayer") 
@onready var bullet = preload("res://enemy_bullet_redbullet.tscn")
@onready var gameplay = $".."
@onready var audio = get_node ("AudioStreamPlayer2D")
@onready var hurt = get_node ("RoboHurt")

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
		player._getExp(xpValue)
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
	audio.play()
	gameplay.add_child(newBullet)
	newBullet.dirX = bulletDir
	newBullet.dirY = 0
	newBullet.MaxSpeed = 500
	newBullet.MaxDistance = 2000
	newBullet.hasdeathAnim = false
	newBullet.position.x = bulletPoint.global_position.x if bulletDir == 1 else bulletPoint2.global_position.x
	newBullet.position.y = bulletPoint.global_position.y if bulletDir == 1 else bulletPoint2.global_position.y
	newBullet.dmg = bulletDmg
	anim.play("shoot")

func _takeDamage(dmg = 5):
	hurt.play()
	health-=5
