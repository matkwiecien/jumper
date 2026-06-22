extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value  = SettingsController.get_master_volume()

func _on_master_volume_value_changed(value: float) -> void:
	SettingsController.set_master_volume(value)
	AudioController.set_master_volume(value)
