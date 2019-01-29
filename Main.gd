extends Node

export (PackedScene) var Mob
var score
var level
var hit_count

func _ready():
	randomize()
	

func game_over():
	$ScoreTimer.stop()
	$LevelTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	level = 1
	hit_count = 0
	$Player1.start($StartPosition1.position)
	$Player2.start($StartPosition2.position)
	$StartTimer.start()
	$LevelTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_StartTimer_timeout():
	$MobTimer.wait_time = 1
	$MobTimer.start()
	$ScoreTimer.start()
	$LevelTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))
	

func _on_LevelTimer_timeout():
	level += 1
	$MobTimer.wait_time -= .2
	$HUD.show_message("Level " + str(level))


func _on_Player1_hit():
	hit_count += 1
	if hit_count == 2:
		game_over()


func _on_Player2_hit():
	hit_count += 1
	if hit_count == 2:
		game_over()