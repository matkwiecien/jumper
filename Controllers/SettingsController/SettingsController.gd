extends Node

signal settings_loaded()

var loaded: bool = false
var config =  ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"



var override_config =  ConfigFile.new()

const PROJECT_SETTINGS_OVERWRITE_FILE_PATH = "user://override.cfg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("video", "fullscreen",  DisplayServer.WINDOW_MODE_FULLSCREEN)
		config.set_value("audio", "music_volume",  0.5)
		config.set_value("audio", "sfx_volume",  0.5)
		config.set_value("audio", "mute_on_focus_loss",  true)
		config.set_value("audio", "master_volume",  0.5)
		config.save(SETTINGS_FILE_PATH)
		loaded = true
		settings_loaded.emit()
	else:
		config.load(SETTINGS_FILE_PATH)		
		loaded = true
		settings_loaded.emit()
		
	if not FileAccess.file_exists(PROJECT_SETTINGS_OVERWRITE_FILE_PATH):
		override_config.set_value("display", "window/size/mode",  DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		override_config.load(PROJECT_SETTINGS_OVERWRITE_FILE_PATH)		
		
func save_settings():
	config.save(SETTINGS_FILE_PATH)

func get_window_mode():
	return override_config.get_value("display", "window/size/mode")

func set_fullscreen(toggle_on: bool):
	if toggle_on:
		override_config.set_value("display", "window/size/mode", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		override_config.set_value("display", "window/size/mode", DisplayServer.WINDOW_MODE_WINDOWED)
	
	override_config.save(PROJECT_SETTINGS_OVERWRITE_FILE_PATH)
	
func is_fullscreen():
	if not loaded:
		print("not loaded")
		
	return override_config.get_value("display", "window/size/mode") == DisplayServer.WINDOW_MODE_FULLSCREEN
	
func get_music_volume():
	if not loaded:
		print("not loaded")
		
	return config.get_value("audio", "music_volume")
	
func set_music_volume(volume: float):
	config.set_value("audio", "music_volume", volume)
	config.save(SETTINGS_FILE_PATH)

func get_sfx_volume():
	if not loaded:
		print("not loaded")
		
	return config.get_value("audio", "sfx_volume")
	
func set_sfx_volume(volume: float):
	config.set_value("audio", "sfx_volume", volume)
	config.save(SETTINGS_FILE_PATH)
	
func get_mute_on_focus_loss():
	if not loaded:
		print("not loaded")
	
	return config.get_value("audio", "mute_on_focus_loss")
	
func set_mute_on_focus_loss(mute: bool):
	config.set_value("audio", "mute_on_focus_loss", mute)
	config.save(SETTINGS_FILE_PATH)
	
func get_master_volume():
	if not loaded:
		print("not loaded")
		
	return config.get_value("audio", "master_volume")
	
func set_master_volume(volume: float):
	config.set_value("audio", "master_volume", volume)
	config.save(SETTINGS_FILE_PATH)
