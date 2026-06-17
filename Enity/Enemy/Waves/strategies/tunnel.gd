extends WaveStrategy
class_name TunnelStrategy

@export var gap_start_y_begining: float = 120	
@export var gap_start_y_end: float = 120

func get_gap_start_y(time: float):
	var progress= calc_progress(time)
	var diffrence = gap_start_y_end - gap_start_y_begining
	return gap_start_y_begining + progress * diffrence

func get_bottom_segment(time: float):
	var gap_start_y = get_gap_start_y(time)
	var tick_height = valid_y_end - (gap_start_y + gap) 
	var y_start = gap_start_y + gap
	var y_end = valid_y_end
	
	
	return {
			'start_y': y_start,
			'end_y': y_end,
			'height': tick_height,
			'number_of_enemies': int(tick_height / enemy_height)
		}
	
func get_top_segment(time: float):
	var gap_start_y = get_gap_start_y(time)
	var tick_height = gap_start_y - valid_y_start
	var y_start =  valid_y_start
	var y_end = gap_start_y
	
	
	return {
			'start_y': y_start,
			'end_y': y_end,
			'height': tick_height,
			'number_of_enemies': int(tick_height / enemy_height)
		}

func create_wave(enemy_container: Node2D, game_time: float, _wave_count: int): 
	var top_segment= get_top_segment(game_time)
	var bottom_segment = get_bottom_segment(game_time)
	var segments =  [top_segment, bottom_segment]
	var speed = calc_expected_speed(game_time)

	for segment in segments:
		create_segment_wave(segment, enemy_container, speed)
	
	
