extends Node
class_name StageManager

enum STAGE_STATE {
	STAGE_STOPPED,
	STAGE_RUNNING,
}

signal game_time_changed(time: float)
signal stage_time_changed(time: float)
signal stage_stopped()

@export var stages: Array[Stage] = []
@export var enemy_wave_generator: EnemyWaveGenerator
@export var stage_progress: StageProgress

@export var current_stage_index: int = 0
@export var current_wave_index: int = 0

var stage_state: STAGE_STATE = STAGE_STATE.STAGE_STOPPED

var game_time: float = 0:
	get: return game_time
	set(value):
		game_time = value
		game_time_changed.emit(game_time)
		
	
func get_current_stage() -> Stage:
	return stages[current_stage_index]
	
func get_current_waves() -> Array[WaveStrategy]:
	return stages[current_stage_index].waves

func is_stage_end(next_wave_index: int) -> bool:
	var waves = get_current_waves()
	return next_wave_index >= waves.size()

func is_wave_timeouted():
	var waves = get_current_waves()
	var current_wave = waves[current_wave_index] 
	return game_time > current_wave.wave_time

func next_wave():
	var new_wave_index = current_wave_index + 1
	
	if is_stage_end(new_wave_index):
		stop_stage()
		return		
	
	load_wave_by_index(new_wave_index)
	
	
func next_stage():
	var new_stage_index = current_stage_index + 1
	if new_stage_index >= stages.size():
		print("no more stages")
		return 
		
	load_stage_by_index(new_stage_index, 0)
	SaveGameController.save_game(new_stage_index, 3)
	
func load_wave_by_index(index: int):
	var waves = get_current_waves()
	current_wave_index = index	
	if stage_progress:
		stage_progress.load_next_wave(index)
	
	game_time = 0
	enemy_wave_generator.init_wave(waves[current_wave_index] )
	stage_time_changed.emit(waves[current_wave_index].wave_time)
	
func load_stage_by_index(stage_index: int, wave_index: int):
	current_stage_index = stage_index	
	if stage_progress:
		stage_progress.load_stage(stages[current_stage_index])
	load_wave_by_index(wave_index)


func _process(delta: float) -> void:
	if stage_state == STAGE_STATE.STAGE_STOPPED:
		return
	
	game_time += delta
	enemy_wave_generator.game_time = game_time
	stage_progress.update_game_time(game_time)
	
	if is_wave_timeouted():
		next_wave()
		
func is_stopped():
	return stage_state == STAGE_STATE.STAGE_STOPPED
	
func stop_stage():
	stage_state = STAGE_STATE.STAGE_STOPPED
	enemy_wave_generator.stop()
	stage_stopped.emit()
	
func start_stage():
	stage_state = STAGE_STATE.STAGE_RUNNING
	enemy_wave_generator.start()
