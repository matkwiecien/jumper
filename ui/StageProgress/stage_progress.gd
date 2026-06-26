extends Control
class_name StageProgress


@export var wave_progress_scene: PackedScene
@export var wave_icon_scene: PackedScene

var wave_progresses: Array[WaveProgress] = []
var wave_index: int = 0

func load_stage(stage: Stage) -> void:
	var waves_total_time = stage.get_waves_total_time()
	
	
	var waves = stage.waves.duplicate()
	waves.reverse()
	for wave in waves:
		var percent_of_total_time = wave.wave_time / waves_total_time		
		
		
		var wave_progress = wave_progress_scene.instantiate() as WaveProgress
		wave_progress.size_flags_stretch_ratio = percent_of_total_time
		wave_progress.load_wave(wave)
		wave_progresses.push_front(wave_progress)
		add_child(wave_progress)
		##
		var wave_icon = wave_icon_scene.instantiate() as Control
		add_child(wave_icon)
		
func update_game_time(time: float):
	wave_progresses[wave_index].update_time(time)
	
