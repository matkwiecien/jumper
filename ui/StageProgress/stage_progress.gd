extends ProgressBar
class_name StageProgress

var current_stage_time = 0

var current_stage: Stage
var current_wave_max_time = 0
var waves_start_times = []
var current_wave_index = 0


@export var marker_texture: Texture2D
@export var marker_success_texture: Texture2D
@export var marker_texture_offset: Vector2

func load_next_wave(wave_index: int):
	current_wave_index = wave_index
	current_stage_time = current_stage.get_waves_to_index_total_time(wave_index)
	current_wave_max_time = current_stage.waves[wave_index].wave_time

func load_stage(stage: Stage) -> void:
	current_stage = stage
	
	max_value = stage.get_waves_total_time()
	value = 0
	current_stage_time = 0
	current_wave_index = 0
	
	waves_start_times = stage.get_waves_start_times()
	current_wave_max_time = current_stage.waves[0].wave_time

func update_game_time(time: float):
	value = current_stage_time + min(time, current_wave_max_time)
	
func _draw() -> void:
	var bar_height = size.y
	
	var index = 0
	for cp_time in waves_start_times:
		var cp_ratio = 1 - cp_time / max_value
		var cp_y = cp_ratio * bar_height
		if index < current_wave_index:
			draw_texture(marker_success_texture, Vector2(-marker_texture.get_size().x/2 + marker_texture_offset.x, cp_y - marker_texture.get_size().y/2 + marker_texture_offset.x))
		else:
			draw_texture(marker_texture, Vector2(-marker_texture.get_size().x/2 + marker_texture_offset.x, cp_y - marker_texture.get_size().y/2 + marker_texture_offset.x))
		index += 1
