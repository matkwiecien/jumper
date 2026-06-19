extends Node

var settings =  ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE_PATH):
		var current_mode = DisplayServer.window_get_mode()
		settings.set_value("video", "fullscreen",  current_mode)
		settings.save(SETTINGS_FILE_PATH)
	else:
		settings.load(SETTINGS_FILE_PATH)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func save_settings():
	settings.save(SETTINGS_FILE_PATH)

func get_window_mode():
	return settings.get_value("video", "fullscreen")
