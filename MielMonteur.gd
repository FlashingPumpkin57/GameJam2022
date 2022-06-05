extends KinematicBody2D

signal hit


export var speed = 400
const default_gravity = 300
export var gravity = default_gravity
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
		
	var coll = move_and_collide(vel)
	
	if coll != null:
		gravity = 0
		move_local_x(vel.x)
		move_local_y(vel.y)
	else:
		gravity = default_gravity
		
	var on_ground = gravity == 0

	if vel.y < 0:
		$AnimatedSprite.animation = "up"
	elif vel.y > 0 && !on_ground:
		$AnimatedSprite.stop()
	if on_ground && vel.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = vel.x < 0
	if idle:
		$AnimatedSprite.animation = "idle"
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
