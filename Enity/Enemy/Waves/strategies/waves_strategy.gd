extends Resource
class_name WaveStrategy

@export var init_wave_delay_time: float = 1.5

@export var time_between_waves_min: float = 1.5
@export var time_between_waves_max: float = 2.5

@export var valid_y_start: float = 20
@export var valid_y_end: float = 340

@export var enemy_scene: PackedScene
@export var enemy_height:  int = 32

@export var gap: float = 120
@export var valid_gap_min_y: float  = 20
@export var valid_gap_max_y: float  = 340
 
@export var wave_time: float = 120
@export var params_maximization_time: float = 120

@export var start_speed: float = 100
@export var end_speed: float = 150

@export var max_y_shift: float = 0

func draw_segments():
	var segments = []
	if is_zero_approx(gap):		
		var segment_height =  valid_y_end - valid_y_start
		segments.append({
			'start_y': valid_y_start,
			'end_y': valid_y_end,
			'height': segment_height,
			'number_of_enemies': int(segment_height / enemy_height)
		})
		return segments
	
	randomize()
	var gap_y_start =  randf_range(valid_gap_min_y, valid_gap_max_y - gap)
	
	
	var gap_y_end = gap_y_start + gap

	if gap_y_start - valid_y_start > enemy_height:
		var segment_height =  gap_y_start - valid_y_start 
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
			'end_y': valid_y_end,
			'height': segment_height,
			'number_of_enemies': int(segment_height / enemy_height)
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
		enemy.global_position.y = enemy_y
		enemy.global_position.x = 640 + randf_range(-32, 64)	
		enemy.target_position = Vector2(-16, enemy.global_position.y)
		enemy_container.add_child(enemy)
		
func get_time_between_waves(time: float) -> float:
	var diff_time = time_between_waves_max - time_between_waves_min
	var progress_percent = calc_progress(time)
	
	return time_between_waves_min + progress_percent * diff_time

func calc_expected_speed(time: float) -> float:
	var speed_diff = end_speed - start_speed;
	var max_time = min(wave_time, params_maximization_time)
	var progress_percent = calc_progress(time)
	
	return start_speed + progress_percent * speed_diff
	
func calc_progress(time: float):
	var max_time = min(wave_time, params_maximization_time)
	return min(time / max_time, 1)
	
func get_last_wave_fly_time():

	return 640 / end_speed
