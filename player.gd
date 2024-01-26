extends CharacterBody2D


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
@onready var bullet = preload("res://bullet.tscn")

func _ready():
	anim.play("Idle")
	audio = get_node("PlayerAudio")
	bulletPoint = get_node("BulletSpawnPoint")
	gameplay = $".."
	
	dead = false
	
func _physics_process(delta):
	bulletCooldown -= delta *100
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if !isShooting:
			anim.play("Jump")
		#audio.play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
