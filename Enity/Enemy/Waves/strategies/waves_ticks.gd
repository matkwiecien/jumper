extends WaveStrategy
class_name WavesTicks


func get_bottom_segment():
	var tick_height = (valid_y_end - valid_y_start) - gap
	var y_start =  valid_y_end - tick_height
	var y_end = valid_y_end
	
	
	return {
			'start_y': y_start,
			'end_y': y_end,
			'height': tick_height,
			'number_of_enemies': int(tick_height / enemy_height)
		}
	
func get_top_segment():
	var tick_height = (valid_y_end - valid_y_start) - gap
	var y_start =  valid_y_start
	var y_end = valid_y_start + tick_height
	
	
	return {
			'start_y': y_start,
			'end_y': y_end,
			'height': tick_height,
			'number_of_enemies': int(tick_height / enemy_height)
		}

func create_wave(enemy_container: Node2D, game_time: float, _wave_count: int): 
	var down_tick = _wave_count % 2 == 0
	var tick_height = (valid_y_end - valid_y_start) - gap
	var speed = calc_expected_speed(game_time)
	
	if down_tick:
		var segment = get_bottom_segment()
		create_segment_wave(segment, enemy_container, speed)
	else:
		var segment = get_top_segment()
		create_segment_wave(segment, enemy_container, speed)
	

	
