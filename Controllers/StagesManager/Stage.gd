extends Resource
class_name Stage

@export var waves: Array[WaveStrategy] = []

func get_waves_total_time() -> float:
	var waves_total_time = 0
	for wave in waves:
		waves_total_time += wave.wave_time
		
	return waves_total_time
