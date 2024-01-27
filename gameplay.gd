extends Node2D
var paused = false

@onready var LevelUpPanel = $UI/LevelUpPanel
@onready var player = $Player
@onready var bossHud = $UI/BossHP
var PowerUpIndex1 = 1
var PowerUpIndex2 = 2
var PowerUpIndex3 = 3

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
	LevelUpPanel._levelUpPanelOpened(1,2,3)

func _grantPowerUp(index):
	match index:
		1:
			player.maxJumpCount+=1
		2:
			player.SPEED+= 100
		3:
			player.bulletCooldown = player.bulletCooldown/2
	player.nextXP = player.nextXP*2
	LevelUpPanel.visible = false
	get_tree().paused = false

func _showBossHud():
	bossHud.visible = true
