extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


func new_game():
	$MielMonteur.start($StartPosition.position)
