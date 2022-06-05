extends StaticBody2D

# Declare member variables here. Examples:
var binItems = ["bootspul", "lingo", "ball", "meme1", "meme2", "meme3"]
var locations = [Vector2(960,540), Vector2(960,530), Vector2(960,520), Vector2(960,510), Vector2(960,500), Vector2(960,490)]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_items():
	return binItems
	
func get_locations():
	return locations

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if (binItems == []):
#		emit_signal("explode")
