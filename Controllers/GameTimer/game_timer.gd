extends Node
class_name GameTimer

@export var total_stage_time: float = 360

@export var flower_last_time_creation_offset: float = 30

signal game_time_change(game_time: float)
var game_time: float = 0 :
	get: return game_time
	set(value): 
		game_time = value
		game_time_change.emit(game_time)
		
signal game_timeout()

signal create_platform_with_flower()


var flower_interval = 0
var created_flowers = 0

#func _should_create_flower():
	#if created_flowers >= level.number_of_flowers:
		#return false
	#
	#if game_time > (created_flowers + 1) * flower_interval:
		#return true
		#
	#if game_time > level.total_game_time - flower_last_time_creation_offset:
		#return true
		#
	#return false

#func _ready() -> void:
	#flower_interval = (level.total_game_time - flower_last_time_creation_offset)/level.number_of_flowers

func _process(delta: float) -> void:
	game_time += delta
	#if _should_create_flower():
		#create_platform_with_flower.emit()
		#created_flowers += 1
	
	if is_game_timeout():
		game_timeout.emit()
		set_process(false)
		
func is_game_timeout():
	return game_time > total_stage_time
	
func _on_stage_time_change(_total_stage_time: float):
	total_stage_time = _total_stage_time

func _on_new_stage_loaded(_stage_index: int):
	game_time = 0
	set_process(true)

		
