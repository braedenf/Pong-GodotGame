extends Node2D

#meber variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

#Constant for pad speed
const INITIAL_BALL_SPEED = 80
#Speed of the ball
var ball_speed = INITIAL_BALL_SPEED
#Constant for pad speed
const PAD_SPEED = 150

func _process(delta):
	var ball_pos = get_node("ball").get_pos()
	var left_rect = Rect2(get_node("left").get_pos() - pad_size*0.5, pad_size)
	var right_rect = Rect2(get_node("right").get_pos() - pad_size*0.5, pad_size)
	
	#intergrate new ball position
	ball_pos += direction * ball_speed * delta
	#flip direction when touching roof or floor
	if((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	#Flip, change direction and speed when hitting the pads
	if((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
		
	#check if gameover
	if(ball_pos.x < 0 or ball_pos.x > screen_size.x):
		ball_pos = screen_size*0.5
		ball_speed = INITIAL_BALL_SPEED
		direction = Vector2(-1, 0)

func _ready():
	screen_size = get_viewport_rect().size()
	pad_size = get_node("left").get_texture().get_size()
	set_process(true)
	
