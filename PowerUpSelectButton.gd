extends Button

@onready var gameplay = $"../../../.."
@export var powerUpIndex : int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	gameplay._grantPowerUp(powerUpIndex) # Replace with function body.
