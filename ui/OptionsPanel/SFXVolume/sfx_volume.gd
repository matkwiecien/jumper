extends HSlider

func _ready() -> void:
	value  = SettingsController.get_master_volume()


func _on_sfx_volume_value_changed(value: float) -> void:
	SettingsController.set_sfx_volume(value)
	AudioController.set_sfx_volume(value)
