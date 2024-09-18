extends CharacterBody2D

const START_SPEED : int = 500
const ACCEL : int = 50
var win_size : Vector2
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.6

# Called when node enters the scene tree for the first time
func _ready() -> void:
	win_size = get_viewport_rect().size

func new_ball() -> void:
	# Randomize start position and direction
	position.x = win_size.x /2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		# if ball hits paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCEL
			dir = new_direction(collider)
		# if it hits a wall
		else:
			dir = dir.bounce(collision.get_normal())

func random_direction() -> Vector2:
	var new_dir := Vector2()
	new_dir.x = [1,-1].pick_random() # left or right
	new_dir.y = randi_range(-1,1) # up or down
	return new_dir.normalized()
	
func new_direction(collider) -> Vector2:
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	if dir.x > 0:
		new_dir.x =-1
	else:
		new_dir.x =1
	new_dir.y =(dist/(collider.p_height/2)) * MAX_Y_VECTOR
	return new_dir.normalized()
	
	 
