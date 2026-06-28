extends Resource
class_name Stage

@export var waves: Array[WaveStrategy] = []

func get_waves_total_time() -> float:
	var waves_total_time = 0
	for wave in waves:
		waves_total_time += wave.wave_time + wave.init_wave_delay_time 
		
	return waves_total_time

func get_waves_to_index_total_time(index: int) -> float:
	var waves_total_time = 0
	var end = index
	for i in end:
		var wave = waves[i]
		waves_total_time += wave.wave_time + wave.init_wave_delay_time
		
	return waves_total_time

func get_waves_start_times() -> Array[float]:
	var waves_start: Array[float] = []
	var first_wave_start: float = waves[0].wave_time
	
	var current_time = 0
	for wave in waves:
		current_time += wave.init_wave_delay_time 
		waves_start.append(current_time)
		current_time += wave.wave_time + wave.init_wave_delay_time

	return waves_start
