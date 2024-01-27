extends CharacterBody2D

var health = 100
const SPEED = 125.0
const JUMP_VELOCITY = -250.0
var bulletCooldown = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var bulletPoint
var audio
var dead
var isShooting
var gameplay
var isPointingRight

@onready var anim = get_node("AnimationPlayer") 
@onready var bullet = preload("res://playerBullet.tscn")
@onready var rb = $RigidBody2D
@onready var hpLabel = $"../UI/Label"
@onready var hpBar = $"../UI/HealthBar"

func _ready():
	anim.play("Idle")
	audio = get_node("PlayerAudio")
	bulletPoint = get_node("BulletSpawnPoint")
	gameplay = $".."
	
	dead = false
	
func _physics_process(delta):
	hpBar.value = health
	hpLabel.text = str(health) + "/100"
	bulletCooldown -= delta *100
		
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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
	
	if(Input.is_action_just_pressed("Fire") && bulletCooldown <= 0):
		isShooting = true
		bulletCooldown = 60
		var newBullet = bullet.instantiate()
		gameplay.add_child(newBullet)
		newBullet.position.x = bulletPoint.global_position.x
		newBullet.position.y = bulletPoint.global_position.y
		anim.play("Shoot")
		await anim.animation_finished
		isShooting = false
		
	if !dead:
		move_and_slide()

	move_and_slide()


func _on_damage_box_body_entered(body):
	if(body.get_name().contains("Enemy") && body.die == false) :
		if(isPointingRight):
			velocity.y = JUMP_VELOCITY
			velocity.x = JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY
			velocity.x = -JUMP_VELOCITY
		health-=5
		body.die = true


func _on_damage_box_area_entered(area):
	if(area.get_name().contains("Enemy") && area.get_parent().die == false) :
		health-=5
		area.get_parent().die = true
