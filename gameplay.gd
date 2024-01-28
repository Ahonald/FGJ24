extends Node2D
var paused = false

@onready var LevelUpPanel = $UI/LevelUpPanel
@onready var player = $Player
@onready var bossHud = $UI/BossHP
@onready var gameOverHud = $UI/GameOverHud
@onready var xptallyLabel = $UI/GameOverHud/XPTally

@onready var gameCompleteHud = $UI/GameCompleteHud
@onready var playerStatsHud = $UI/PlayerStats
@onready var completeLVLTally =$UI/GameCompleteHud/TextureRect/LVLTally
@onready var completeXPTally =$UI/GameCompleteHud/TextureRect/XPTally
@onready var toMainMenuButton = $UI/GameCompleteHud/TextureRect/MenuButton

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
			player.SPEED+= 25
		2:
			player.bulletCooldown = player.bulletCooldown/2
		3:
			player.maxHealth+=20
			player.health = player.maxHealth
		4:
			player.bulletCount+=1
		5:
			player.bulletDamge+=2
			
	player.nextXP = int(player.nextXP*2)
	player.level+=1
	LevelUpPanel.visible = false
	get_tree().paused = false

func _showBossHud():
	bossHud.visible = true

func _gameOver():
	gameOverHud.visible = true
	playerStatsHud.visible = false
	xptallyLabel.text = "XP acquired: " + str(player.xp)

func _completeGame():
	player.set_physics_process(false)
	playerStatsHud.visible = false
	gameCompleteHud.visible = true
	toMainMenuButton.grab_focus()
	completeLVLTally.text = "Levels acquired: " + str(player.level)
	completeXPTally.text = "XP accrued: " + str(player.xp)


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
