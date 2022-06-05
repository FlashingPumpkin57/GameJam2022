extends Node

var recyclePre = preload("res://RecycleBinWindow.tscn")
var explosionPre = preload("res://explosion.tscn")
var recycleBin
var explosion
var timerDone = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func _process(_delta):
	if !timerDone && $Timer.is_stopped():
		timerDone = true
		remove_child(recycleBin)
	
	if !has_node("explosion") && recycleBin.binItems == []:
		add_child(explosion)
		remove_child(get_node("Win11TrashCan"))
		explosion.play()

func new_game():
	recycleBin = recyclePre.instance()
	explosion = explosionPre.instance()
	$MielMonteur.start($StartPosition.position)

func _on_Win11TrashCan_body_entered(body):
	call_deferred("add_child", recycleBin)
	body.position = recycleBin.get_node("StartingPosition").position
	$Timer.start()
	timerDone = false


func _on_MielMonteur_slash():
	recycleBin.binItems = []
#	recycleBin.remove_child(recycleBin.get_node("meme1"))
#	recycleBin.remove_child(recycleBin.get_node("meme1_coll"))
#	for _i in recycleBin.get_locations():
#		print(_i)
