extends KinematicBody2D


const GRAVITY = 600
const WALK_SPEED = 350
const JUMP_FORCE = 500

var velocity = Vector2()
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	

func _physics_process(delta):
	var idle = true
	velocity.y += delta * GRAVITY
	
	$AnimatedSprite.play()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		idle = false
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		idle = false
	else:
		velocity.x = 0
		# smoothen the stop
		# velocity.x = lerp(velocity.x, 0, 0.1)
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP_FORCE
		idle = false
	 
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# prevent player going out of screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.y != 0:
		if velocity.y > 0:
			$AnimatedSprite.animation = "fall"
		else:
			$AnimatedSprite.animation = "up"
	elif velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
	if idle:
		$AnimatedSprite.animation = "idle"
	
	print(velocity)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
