extends Node

var recyclePre = preload("res://RecycleBinWindow.tscn")
var recycleBin
var timerDone

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func _process(delta):
	if !timerDone && $Timer.is_stopped():
		timerDone = true
		remove_child(recycleBin)

func new_game():
	recycleBin = recyclePre.instance()
	$MielMonteur.start($StartPosition.position)

func _on_Win11TrashCan_body_entered(body):
	call_deferred("add_child", recycleBin)
	body.position = recycleBin.get_node("StartingPosition").position
	$Timer.start()
	timerDone = false
