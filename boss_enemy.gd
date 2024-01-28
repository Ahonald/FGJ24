extends CharacterBody2D

var hp = 2000
var maxHp = 2000
var dmg = 10
@onready var hpBar = $"../UI/BossHP/BossHPBar"

@onready var gameplay = $".."
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var isPerformingMove = false
var isWaitingForNextMove = true
var waitTime = 1.5
var moveIndex = 0
var rng = RandomNumberGenerator.new()
var posDist

var dashVelocity = 500


@onready var LeftHandPosition = $LeftHandPosition
@onready var RightHandPosition = $RightHandPosition

@onready var LeftHandHighPosition = $LeftHandHighPosition
@onready var RightHandHighPosition = $RightHandHighPosition
@onready var anim = $AnimatedSprite2D/AnimationPlayer

var rightPos
var leftPos
var rightHighPos
var leftHighPos

var entry = true
var entryTime = 0
var entryMaxTime = 8
var entrySpeed = 25

var die = false

@onready var bullet = preload("res://enemy_bullet_redbullet.tscn")
@onready var RHB1 = $RightHandBullets/RHB
@onready var RHB2 = $RightHandBullets/RHB2
@onready var RHB3 = $RightHandBullets/RHB3
@onready var RHB4 = $RightHandBullets/RHB4
@onready var RHB5 = $RightHandBullets/RHB5
@onready var RHB6 = $RightHandBullets/RHB6
@onready var LHB1 = $LeftHandBullets/LHB
@onready var LHB2 = $LeftHandBullets/LHB2
@onready var LHB3 = $LeftHandBullets/LHB3
@onready var LHB4 = $LeftHandBullets/LHB4
@onready var LHB5 = $LeftHandBullets/LHB5
@onready var LHB6 = $LeftHandBullets/LHB6

var isDashing = false

func _ready():
	pass
	#leftPos = LeftHandPosition.global_position
	#rightPos = RightHandPosition.global_position
	#leftHighPos = LeftHandHighPosition.global_position
	#rightHighPos = RightHandHighPosition.global_position
	#_doBossLogic()
	

func _doBossLogic():
		while true:
			if(!isWaitingForNextMove && !isDashing && !die):
				moveIndex = int(rng.randf_range(0, 8))
				isPerformingMove = true
				match moveIndex:
					0:
						global_position = leftPos
						isDashing = true
					1:
						global_position  = leftPos
						var newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB1.global_position.x 
						newBullet.position.y = RHB1.global_position.y
						
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB2.global_position.x 
						newBullet.position.y = RHB2.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB3.global_position.x 
						newBullet.position.y = RHB3.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB4.global_position.x 
						newBullet.position.y = RHB4.global_position.y	
											
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB5.global_position.x 
						newBullet.position.y = RHB5.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB6.global_position.x 
						newBullet.position.y = RHB6.global_position.y	
						
						isPerformingMove = false
						isWaitingForNextMove = true
					2:
						global_position = rightPos
						var newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB1.global_position.x 
						newBullet.position.y = LHB1.global_position.y
						
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB2.global_position.x 
						newBullet.position.y = LHB2.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB3.global_position.x 
						newBullet.position.y = LHB3.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB4.global_position.x 
						newBullet.position.y = LHB4.global_position.y	
											
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB5.global_position.x 
						newBullet.position.y = LHB5.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB6.global_position.x 
						newBullet.position.y = LHB6.global_position.y	
						
						isPerformingMove = false
						isWaitingForNextMove = true
					3:
						global_position = rightPos
						isDashing = true
					4:
						global_position = rightHighPos
						isDashing = true
					5:
						global_position = leftHighPos
						isDashing = true
					6:
						global_position = rightHighPos
						var newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB1.global_position.x 
						newBullet.position.y = LHB1.global_position.y
						
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB2.global_position.x 
						newBullet.position.y = LHB2.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB3.global_position.x 
						newBullet.position.y = LHB3.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB4.global_position.x 
						newBullet.position.y = LHB4.global_position.y	
											
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB5.global_position.x 
						newBullet.position.y = LHB5.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = -1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = LHB6.global_position.x 
						newBullet.position.y = LHB6.global_position.y	
						
						isPerformingMove = false
						isWaitingForNextMove = true
					7:
						global_position = leftHighPos
						var newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB1.global_position.x 
						newBullet.position.y = RHB1.global_position.y
						
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB2.global_position.x 
						newBullet.position.y = RHB2.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB3.global_position.x 
						newBullet.position.y = RHB3.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB4.global_position.x 
						newBullet.position.y = RHB4.global_position.y	
											
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = 800
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB5.global_position.x 
						newBullet.position.y = RHB5.global_position.y
												
						newBullet = bullet.instantiate()
						gameplay.add_child(newBullet)
						newBullet.dirX = 1
						newBullet.dirY = 0
						newBullet.MaxSpeed = rng.randf_range(600, 1200)
						newBullet.MaxDistance = 2000
						newBullet.hasdeathAnim = false
						newBullet.position.x = RHB6.global_position.x 
						newBullet.position.y = RHB6.global_position.y	
						
						isPerformingMove = false
						isWaitingForNextMove = true
							
			else:
				var timeOut = waitTime * (hp/maxHp)
				await get_tree().create_timer(timeOut).timeout
				isWaitingForNextMove = false

	
func _physics_process(delta):
	hpBar.value = hp
	
	if(isDashing && !die):
		if(moveIndex == 0):
			if(global_position.x < rightPos.x):
				global_position.x += delta*dashVelocity
			else:
				isDashing = false
				isPerformingMove = false
				isWaitingForNextMove = true
				
		if(moveIndex == 3):
			if(global_position.x > leftPos.x):
				global_position.x -= delta*dashVelocity
			else:
				isDashing = false
				isPerformingMove = false
				isWaitingForNextMove = true
				
		if(moveIndex == 4):
			if(global_position.x > leftHighPos.x):
				global_position.x -= delta*dashVelocity
			else:
				isDashing = false
				isPerformingMove = false
				isWaitingForNextMove = true
				
		if(moveIndex == 5):
			if(global_position.x < rightHighPos.x):
				global_position.x += delta*dashVelocity

			else:
				isDashing = false
				isPerformingMove = false
				isWaitingForNextMove = true
				
	if(entry && entryTime < entryMaxTime):
		global_position.y += delta*entrySpeed
		entryTime+=delta
		
	elif(entry && entryTime >= entryMaxTime):
			entry = false
			leftPos = LeftHandPosition.global_position
			rightPos = RightHandPosition.global_position
			leftHighPos = LeftHandHighPosition.global_position
			rightHighPos = RightHandHighPosition.global_position
			get_tree().create_timer(3).timeout
			_doBossLogic()
			
func _takeDamage(dmg):
	hp-=dmg
	if(hp<= 0):
		die = true
		_death()
		
func _death():
	gameplay._completeGame()
	anim.play("Explode")
	await get_tree().create_timer(3).timeout
	queue_free()
