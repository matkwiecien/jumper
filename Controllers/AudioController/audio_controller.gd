extends Node

@export var mute: bool

var mute_on_focus_loose: bool = false

@onready var music: AudioStreamPlayer2D = $Music
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var dash: AudioStreamPlayer2D = $Dash
@onready var collect: AudioStreamPlayer2D = $Collect
@onready var punch: AudioStreamPlayer2D = $Punch

func _ready() -> void:
	SettingsController.settings_loaded.connect(_load_settings)
	if SettingsController.loaded:
		_load_settings()
	
func _load_settings() -> void:
	mute_on_focus_loose = SettingsController.get_mute_on_focus_loss()
	set_music_volume(SettingsController.get_music_volume())
	set_master_volume(SettingsController.get_master_volume())
	set_sfx_volume(SettingsController.get_sfx_volume())
	
	
func _notification(what: int) -> void:
	if mute_on_focus_loose:		
		match what:
			NOTIFICATION_WM_WINDOW_FOCUS_OUT:
				## Mutes the Master bus (index 0) when the game loses focus
				AudioServer.set_bus_mute(0, true)
			NOTIFICATION_WM_WINDOW_FOCUS_IN:
				# Unmutes the Master bus when the game regains focus
				AudioServer.set_bus_mute(0, false)

func play_jump() -> void:
	if not mute:
		jump.play()

func play_dash() -> void:
	if not mute:
		dash.play()

func play_collect() -> void:
	if not mute:
		collect.play()

func play_punch() -> void:
	if not mute:
		punch.play()
		
func set_music_volume(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func set_sfx_volume(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func set_master_volume(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
