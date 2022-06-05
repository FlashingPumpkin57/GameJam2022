extends KinematicBody2D

signal slash

const GRAVITY = 600
const WALK_SPEED = 350
const JUMP_FORCE = 500

var velocity = Vector2()
var screen_size

var animation_playing = false
var facing_right = true

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var idle = true
	velocity.y += delta * GRAVITY
	
	$AnimatedSprite.play()
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
		idle = false
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED
		idle = false
	else:
		velocity.x = 0
		# smoothen the stop
		# velocity.x = lerp(velocity.x, 0, 0.1)
	
	if Input.is_action_pressed("move_up") and is_on_floor():
		velocity.y = -JUMP_FORCE
		idle = false
	if Input.is_action_pressed("attack"):
		if !animation_playing:
			$AnimatedSprite.animation = "slash"
			emit_signal("slash")
		animation_playing = true

	velocity = move_and_slide(velocity, Vector2.UP)
	
	# prevent player going out of screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if !animation_playing:
		if velocity.y != 0:
			if velocity.y > 0:
				$AnimatedSprite.animation = "fall"
			else:
				$AnimatedSprite.animation = "up"
		elif velocity.x != 0:
			$AnimatedSprite.animation = "walk"
			# See the note below about boolean assignment.
			$AnimatedSprite.flip_h = velocity.x < 0
		elif idle:
			$AnimatedSprite.animation = "idle"
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_AnimatedSprite_animation_finished():
	animation_playing = false
