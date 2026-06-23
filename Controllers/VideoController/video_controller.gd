extends Node

func _ready() -> void:
	SettingsController.settings_loaded.connect(_load_settings)
	await get_tree().process_frame
	if SettingsController.loaded:
		_load_settings()
		
func _load_settings() -> void:
	
	var screen_mode = SettingsController.get_window_mode()
	print(screen_mode, DisplayServer.WINDOW_MODE_WINDOWED)
	set_window_mode(screen_mode)

func set_window_mode(screen_mode: DisplayServer.WindowMode):
	DisplayServer.window_set_mode(screen_mode)
	DisplayServer.window_set_mode(screen_mode)
