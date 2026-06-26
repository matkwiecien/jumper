extends Control
class_name WaveProgress

var wave_time: float = 0

@onready var wave_progress_rect: ColorRect = $WaveProgressRect



func _ready() -> void:
	wave_progress_rect.material.set_shader_parameter('current_val', 0)
	wave_progress_rect.material.set_shader_parameter('max_val', wave_time)

func load_wave(wave: WaveStrategy):
	wave_time = wave.wave_time
	if wave_progress_rect and wave_progress_rect.material:
		wave_progress_rect.material.set_shader_parameter('max_val', wave_time)


func update_time(time: float):
	wave_progress_rect.material.set_shader_parameter('current_val', time)
