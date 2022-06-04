extends StaticBody2D

var size setget set_size

func set_size(p_size):
	size = p_size
	# CollisionShape2D is only used in editor! 
	# Use shape_owner to retrieve the actual shape.
	shape_owner_get_shape(0, 0).extents = size / 2
