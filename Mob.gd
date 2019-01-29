extends RigidBody2D

export (int) var min_speed
export (int) var max_speed
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
