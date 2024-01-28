extends Node2D
var paused = false

@onready var LevelUpPanel = $UI/LevelUpPanel
@onready var player = $Player
@onready var bossHud = $UI/BossHP
@onready var gameOverHud = $UI/GameOverHud
@onready var xptallyLabel = $UI/GameOverHud/XPTally

var PowerUpIndex1 = 1
var PowerUpIndex2 = 2
var PowerUpIndex3 = 3

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if Input.is_action_pressed("ui_cancel") and paused == false:
		paused = true
		get_tree().paused = true
	elif Input.is_action_pressed("ui_cancel") and paused == true:
		get_tree().paused = false
		paused = false
		
func _levelUp():
	get_tree().paused = true
	LevelUpPanel.visible = true
	PowerUpIndex1 = int(rng.randf_range(0, 5))
	PowerUpIndex2 = int(rng.randf_range(0, 5))
	while PowerUpIndex1 == PowerUpIndex2:
		PowerUpIndex2 = int(rng.randf_range(0, 5))
	PowerUpIndex3 = int(rng.randf_range(0, 5))
	while PowerUpIndex3 == PowerUpIndex2 || PowerUpIndex3 == PowerUpIndex1:
		PowerUpIndex3 = int(rng.randf_range(0, 5))
	LevelUpPanel._levelUpPanelOpened(PowerUpIndex1,PowerUpIndex2,PowerUpIndex3)

func _grantPowerUp(index):
	match index:
		0:
			player.maxJumpCount+=1
		1:
			player.SPEED+= 100
		2:
			player.bulletCooldown = player.bulletCooldown/2
		3:
			player.maxHealth+=10
			player.health = player.maxHealth
		4:
			player.bulletCount+=1
		5:
			player.bulletDamge+=1
			
	player.nextXP = int(player.nextXP*2)
	player.level+=1
	LevelUpPanel.visible = false
	get_tree().paused = false

func _showBossHud():
	bossHud.visible = true

func _gameOver():
	gameOverHud.visible = true
	xptallyLabel.text = "XP acquired: " + str(player.xp)
