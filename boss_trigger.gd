extends Node2D

@onready var bossDoor = $"../BossDoor"
@onready var gameplay = $".."
@onready var player = $"../Player"
# Called when the node enters the scene tree for the first time.
func _ready():
	bossDoor.visible = false
	bossDoor.process_mode = Node.PROCESS_MODE_DISABLED  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		bossDoor.visible = true
		bossDoor.process_mode = Node.PROCESS_MODE_INHERIT
		player.set_physics_process(false)
		player.anim.play("Idle")
		await get_tree().create_timer(6).timeout
		player.set_physics_process(true)
		gameplay._showBossHud()
		queue_free()
