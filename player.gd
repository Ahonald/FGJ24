extends CharacterBody2D

var health = 100
var maxHealth = 100
var xp = 0
var level = 1
var nextXP = 50
var die = false

var SPEED = 125.0
const JUMP_VELOCITY = -250.0

var bulletCooldown = 60
var currentBulletCooldown = 0
var bulletCount = 1
var bulletDamage = 5

var maxJumpCount = 2
var jumpCount = 2


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var bulletPoint = $BulletSpawnPoint
@onready var bulletPoint2 = $BulletSpawnPoint2
@onready var bulletPoint3 = $BulletSpawnPoint3
@onready var bulletPoint4 = $BulletSpawnPoint4
@onready var bulletPoint5 = $BulletSpawnPoint5
@onready var bulletPoint6 = $BulletSpawnPoint6
@onready var bulletPoint7 = $BulletSpawnPoint7
@onready var bulletPoint8 = $BulletSpawnPoint8


var audio
var dead
var isShooting
var isPointingRight

@onready var anim = get_node("AnimationPlayer") 
@onready var bullet = preload("res://playerBullet.tscn")
@onready var rb = $RigidBody2D
@onready var hpLabel = $"../UI/HP/HPLabel"
@onready var hpBar = $"../UI/HP/HealthBar"
@onready var xpLabel = $"../UI/XP/XPLabel"
@onready var xpBar = $"../UI/XP/XPBar"
@onready var dmgText = $Label
@onready var lvlLabel = $"../UI/LevelLabel"
@onready var gameplay = $".."
@onready var sprite = $AnimatedSprite2D

func _ready():
	anim.play("Idle")
	audio = get_node("PlayerAudio")
	gameplay = $".."
	xpBar.max_value = float(nextXP)
	dead = false

func _physics_process(delta):
	hpBar.value = health
	hpLabel.text = str(health) + "/" + str(maxHealth)
	xpBar.value = xp
	xpLabel.text = "to next: " + str(nextXP-xp)
	lvlLabel.text = "LVL " + str(level)
	
	if(xp >= nextXP):
		gameplay._levelUp()
		xpBar.max_value = float(nextXP)
		
	if(health<= 0 && !die):
		health = 0
		die = true
		anim.play("Die")
		await get_tree().create_timer(1).timeout
		sprite.visible = false
		gameplay._gameOver()
	if(!die):
		currentBulletCooldown -= delta *100
			
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			jumpCount = maxJumpCount

		if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || jumpCount > 0):
			velocity.y = JUMP_VELOCITY
			jumpCount-=1
			if !isShooting:
				anim.play("Jump")
				
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if direction == -1:
				get_node("AnimatedSprite2D").flip_h = true
				isPointingRight = false
			elif direction == 1:
				get_node("AnimatedSprite2D").flip_h = false
				isPointingRight = true
			velocity.x = direction * SPEED
			if velocity.y == 0 && !isShooting:
				anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0 && !isShooting:
				anim.play("Idle")
		if velocity.y > 0 && !dead && !isShooting:
			anim.play("Fall")
		
		if(Input.is_action_just_pressed("Fire") && currentBulletCooldown <= 0):
			isShooting = true
			currentBulletCooldown = bulletCooldown
			
			var newBullet = bullet.instantiate()
			gameplay.add_child(newBullet)
			newBullet.position.x = bulletPoint.global_position.x
			newBullet.position.y = bulletPoint.global_position.y
			newBullet.dmgValue = bulletDamage
			
			if(bulletCount >= 2):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint2.global_position.x
				newBullet.position.y = bulletPoint2.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 3):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint3.global_position.x
				newBullet.position.y = bulletPoint3.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 4):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint4.global_position.x
				newBullet.position.y = bulletPoint4.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 5):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint5.global_position.x
				newBullet.position.y = bulletPoint5.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 6):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint6.global_position.x
				newBullet.position.y = bulletPoint6.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 7):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint7.global_position.x
				newBullet.position.y = bulletPoint7.global_position.y
				newBullet.dmgValue = bulletDamage
			if(bulletCount >= 8):
				newBullet = bullet.instantiate()
				gameplay.add_child(newBullet)
				newBullet.position.x = bulletPoint8.global_position.x
				newBullet.position.y = bulletPoint8.global_position.y
				newBullet.dmgValue = bulletDamage
				
			anim.play("Shoot")
			await anim.animation_finished
			isShooting = false
			
		if !dead:
			move_and_slide()

		move_and_slide()


func _on_damage_box_body_entered(body):
	if(body.get_name().contains("Enemy")) :
		if(isPointingRight):
			velocity.y = JUMP_VELOCITY
			velocity.x = JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY
			velocity.x = -JUMP_VELOCITY
		_takeDmg(body.dmg) 
		#body.die = true


func _on_damage_box_area_entered(area):
	if(area.get_name().contains("Enemy") && area.get_parent().die == false) :
		_takeDmg(area.get_parent().dmg)
		area.get_parent().die = true

func _takeDmg(dmg = 5):
	health-=dmg
	dmgText.displayDmgText(dmg)

func _getExp(expValue = 5):
	xp+=expValue
