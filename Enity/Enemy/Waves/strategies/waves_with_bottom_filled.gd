extends WaveStrategy
class_name WaveWithBottomFilled

@export var bottom_wave_height: float = 32
@export var bottom_wave_density: float = 8

func draw_segments():
	var segments = []
	
	if is_zero_approx(gap):
		var segment_height =  (valid_y_end - bottom_wave_height) - valid_y_start
		segments.append({
			'start_y': valid_y_start,
			'end_y': valid_y_end - bottom_wave_height,
			'height': segment_height,
			'number_of_enemies': int(segment_height / enemy_height)
		})
		
		segments.append({
			'start_y': valid_y_end - bottom_wave_height,
			'end_y': valid_y_end,
			'height': bottom_wave_height,
			'number_of_enemies': int(bottom_wave_height / bottom_wave_density)
		})
		return segments
		
	randomize()
	var gap_y_start =  randf_range(valid_gap_min_y, valid_gap_max_y - gap - bottom_wave_height)
	var gap_y_end = gap_y_start + gap

	if gap_y_start - valid_y_start > enemy_height:
		var segment_height =  gap_y_start - (valid_y_start)
		segments.append({
			'start_y': valid_y_start,
			'end_y': gap_y_start,
			'height': segment_height,
			'number_of_enemies': int(segment_height / enemy_height)
		})
		
	if valid_y_end - gap_y_end > enemy_height:
		var segment_height = valid_y_end - gap_y_end 
		segments.append({
			'start_y': gap_y_end,
			'end_y': valid_y_end - bottom_wave_height,
			'height': segment_height,
			'number_of_enemies': int(segment_height / enemy_height)
		})
		
	segments.append({
		'start_y': valid_y_end - bottom_wave_height,
		'end_y': valid_y_end,
		'height': bottom_wave_height,
		'number_of_enemies': int(bottom_wave_height / bottom_wave_density)
	})
	
	return segments


func create_wave(enemy_container: Node2D, game_time: float, _wave_count: int): 
	var segments = draw_segments()
	var speed = calc_expected_speed(game_time)

	
	for segment in segments:
		create_segment_wave(segment, enemy_container, speed)
	
func create_segment_wave(segment: Dictionary, enemy_container: Node2D, speed: float):	
	var number_of_enemies_to_create = segment['number_of_enemies']
	var distance_betwwen_enemies = segment['height'] / (number_of_enemies_to_create - 1)
	
	for i in number_of_enemies_to_create:
		var enemy_y =  segment['start_y'] + i * distance_betwwen_enemies
		var enemy = enemy_scene.instantiate() as Killer
		enemy.speed = speed
		enemy.global_position.y = clampf(enemy_y + randf_range(-max_y_shift, max_y_shift), segment['start_y'], segment['end_y']) 
		enemy.global_position.x = 640 + randf_range(-32, 64)	
		enemy.target_position = Vector2(-16, enemy.global_position.y)
		enemy_container.add_child(enemy)
		
func get_time_between_waves(time: float) -> float:
	var diff_time = time_between_waves_max - time_between_waves_min
	var progress_percent = min(time / wave_time, 1)
	
	return time_between_waves_min + progress_percent * diff_time

func calc_expected_speed(time: float) -> float:
	var speed_diff = end_speed - start_speed;
	var progress_percent = min(time / wave_time, 1)
	
	return start_speed + progress_percent * speed_diff
	
