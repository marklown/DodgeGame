extends Area2D

export (int) var speed
export (int) var player_number

var screensize

var up = "player1_up"
var down = "player1_down"
var left = "player1_left"
var right = "player1_right"

signal hit

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	if player_number == 1:
		up    = "player1_up"
		down  = "player1_down"
		left  = "player1_left"
		right = "player1_right"
	else:
		up    = "player2_up"
		down  = "player2_down"
		left  = "player2_left"
		right = "player2_right"

func _ready():
	screensize = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed(right):
		velocity.x += 1
	if Input.is_action_pressed(left):
		velocity.x -= 1
	if Input.is_action_pressed(down):
		velocity.y += 1
	if Input.is_action_pressed(up):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "Right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "Up"
		$AnimatedSprite.flip_v = velocity.y > 0
		


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true
