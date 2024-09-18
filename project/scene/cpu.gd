extends StaticBody2D

var ball_pos : Vector2
var dist : int
var move_by : int
var win_height : int
var p_height : int

# Make CPU pepega
const CPU_PADDLE_SPEED : int = 150
var max_move_distance = 100  # Maximum distance the paddle can move in one frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Tell CPU where is the ball
	ball_pos = $"../Ball".position
	# Calc distance between paddle and ball
	# if +ve paddle is below ball. If -ve paddle is above ball
	dist = position.y - ball_pos.y
	
	# Calculate maximum move distance per frame
	var move_distance = min(CPU_PADDLE_SPEED * delta, max_move_distance)
	
	# This checks if the frame time (delta) is larger than the distance the paddle would move in that frame.
	# If the movement is too small, it doesn't bother moving the paddle smoothly, which could cause jittering.
	if abs(delta) > CPU_PADDLE_SPEED * delta:
		# Move up or down with PADDLE_SPEED
		move_by = move_distance * (dist / abs(dist))
		
	# If the paddle is very close to the ball (i.e., the movement amount is very small), instead of moving by a tiny amount, the paddle just "snaps" to the ball’s position (move_by = dist).
	else:
		# Snap Paddle to ball position
		move_by = dist
	
	# Move the paddle
	position.y -= move_by
	
	# Limit paddle to borders
	position.y = clamp(position.y, p_height/2, win_height - p_height/2)
