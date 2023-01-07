extends HuntState

# ПРЕСЛЕДОВАНИЕ
func physics_process(_delta: float) -> BaseState:
	if player: # ИГРОКА
		ray_enemy.look_at(player.global_position)
		check_player_in_detection()
		if player_spotted:
			hunt_line.global_position = Vector2.ZERO
			hunt_generate_path()
			hunt_navigate()
	hunt_move()
	return null
	
# ФУНКЦИЯ ЛУЧА
func check_player_in_detection() -> bool:
	var collider = ray_enemy.get_collider()
	if collider and collider.is_in_group("Player"):
		player_spotted = true
		return true
	else:
		player_spotted = false
	return false
	
# НАВИГАЦИЯ ПУТИ
func hunt_navigate():
	if path.size() > 0:
		velocity = enemy.global_position.direction_to(path[1]) * HUNT_SPEED
		if enemy.global_position == path [0]:
			path.pop_front()
	
# ГЕНЕРАЦИЯ ПУТИ
func hunt_generate_path():
	if LevelNavigation != null and player != null:
		path = LevelNavigation.get_simple_path(enemy.global_position, player.global_position, false)
		hunt_line.points = path
	
# ДВИЖЕНИЕ
func hunt_move():
	velocity = enemy.move_and_slide(velocity)
