extends CharacterBody2D

var score = 0
var time_left = 120
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ladder: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var score_label: Label = $Camera2D/ScoreLabel
@onready var timer_label: Label = $Camera2D/TimerLabel

func _process(delta):
	# Decrement time by the frame delta
	time_left -= delta
	if time_left <= 0:
		# Time is up, end the game
		time_left = 0
		end_game()
	# Update the timer display every frame
	timer_label.text = format_time(time_left)

func format_time(seconds_left: float) -> String:
	var minutes = int(seconds_left / 60)
	var seconds = int(seconds_left) % 60
	if seconds < 10:
		return str(minutes) + ":0" + str(seconds)
	else:
		return str(minutes) + ":" + str(seconds)



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not on_ladder:
		velocity.y += gravity * delta
	if on_ladder:
		if Input.is_action_pressed("climb_down"):
			velocity.y = SPEED * delta * 50
			animated_sprite.play("climb_down")
		elif Input.is_action_pressed("climb_up"):
			velocity.y = -SPEED * delta * 50
			animated_sprite.play("climb_up")
		else:
			velocity.y = 0
			animated_sprite.play("ladder_idle")  # Play ladder_idle animation when not moving

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor() and not on_ladder:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif not on_ladder:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_ladder_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		on_ladder = true

func _on_ladder_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		on_ladder = false
		
func _ready():
	score = 0
	score_label.text = str(score)
	timer_label.text = format_time(time_left)

func add_points(amount):
	score += amount
	score_label.text = str(score)
	if score <= 0:
		end_game()

	
func end_game():
	# Your game-over logic here
	# For example:
	print("Time's up! Game Over.")
	get_tree().reload_current_scene()
	# get_tree().reload_current_scene()  # or load a GameOver scene
	# get_tree().change_scene("res://GameOverScreen.tscn")
	# or you could do get_tree().reload_current_scene() or any other flow
