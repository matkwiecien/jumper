extends ProgressBar

func _on_game_time_changed(game_time: float):
	value = game_time

func _on_stage_time_changed(stage_time: float):
	max_value = stage_time
