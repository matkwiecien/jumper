extends Control

@onready var fullscreen_check_box: CheckBox = $PanelContainer/MarginContainer/VBoxContainer/FullscreenCheckBox
@onready var music_volume: HSlider = $PanelContainer/MarginContainer/VBoxContainer/MusicVolume
@onready var sfx_volume: HSlider = $PanelContainer/MarginContainer/VBoxContainer/SFXVolume

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fullscreen_check_box.button_pressed = SettingsController.is_fullscreen()
	music_volume.value = SettingsController.get_music_volume()
	sfx_volume.value  = SettingsController.get_sfx_volume()
	
func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	SettingsController.set_fullscreen(toggled_on)

func _on_music_volume_value_changed(value: float) -> void:
	SettingsController.set_music_volume(value)

func _on_sfx_volume_value_changed(value: float) -> void:
	SettingsController.set_sfx_volume(value)
