extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = SettingsController.get_music_volume()

func _on_music_volume_value_changed(value: float) -> void:
	SettingsController.set_music_volume(value)
	AudioController.set_music_volume(value)
