extends Control

@onready var fullscreen_check_box: CheckBox = $PanelContainer/MarginContainer/VBoxContainer/FullscreenCheckBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_mode = DisplayServer.window_get_mode()
	fullscreen_check_box.button_pressed = current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN


func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		SettingsController.settings.set_value("video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		SettingsController.settings.set_value("video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
		
	SettingsController.save_settings()
