extends Node2D
class_name EnemyWaveGenerator

var wave: WaveStrategy
var game_time: float = 0
var wave_count: int = 0

@onready var enemy_container: Node2D = $EnemyContainer
@onready var enemy_wave_timer: Timer = $EnemyWaveTimer
@onready var enemy_destory_timeout_timer: Timer = $EnemyDestoryTimeoutTimer

func start_remove_enemy_timeout():
	enemy_destory_timeout_timer.start()

func stop_remove_enemy_timeout():
	enemy_destory_timeout_timer.stop()

func is_all_enemy_removed():
	return enemy_container.get_child_count() <= 0

func remove_all_enemy():
	for child in enemy_container.get_children():
		if not child.is_queued_for_deletion():
			child.queue_free()

func stop():
	enemy_wave_timer.stop()

func start():
	enemy_wave_timer.start()
	
func is_running():
	return not enemy_wave_timer.is_stopped()

func init_wave(_wave: WaveStrategy):
	wave = _wave
	wave_count = 0
	enemy_wave_timer.wait_time = wave.init_wave_delay_time
	

func create_wave():
	if not wave:		
		return

	wave_count += 1
	
	wave.create_wave(enemy_container, game_time, wave_count)
	
	enemy_wave_timer.wait_time = wave.get_time_between_waves(game_time)
	enemy_wave_timer.start()

func _on_enemy_wave_timer_timeout() -> void:
	create_wave()
