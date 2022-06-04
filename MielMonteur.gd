extends KinematicBody2D

signal hit


export var speed = 400
export var gravity = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var vel = Vector2()
	var idle = true
	vel.x = 0
	vel.y = gravity * delta
	if Input.is_action_pressed("move_right"):
		vel.x += 1*speed*delta
		idle = false
	if Input.is_action_pressed("move_left"):
		vel.x -= 1*speed*delta
		idle = false
	if Input.is_action_pressed("move_down"):
		vel.y += 1*speed*delta
		idle = false
	if Input.is_action_pressed("move_up"):
		vel.y -= 1*speed*delta
		idle = false
		
	$AnimatedSprite.play()
		
#	if vel.length() > 0:
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()
	
#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
	
	if vel.x != 0:
		$AnimatedSprite.animation = "walk"
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = vel.x < 0
	elif vel.y != 0:
		$AnimatedSprite.animation = "up"
#		if vel.y > 0:
#			$AnimatedSprite.stop()
	if idle:
#		$AnimatedSprite.play()
		$AnimatedSprite.animation = "idle"
		
	var coll = move_and_collide(vel)
	
	if coll != null:
#		$AnimatedSprite.animation = "walk"
		move_local_x(vel.x)
		move_local_y(vel.y)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
