extends Control
class_name OptionPanel

@onready var fullscreen_check_box: FocusableCheckbox = $MarginContainer/VBoxContainer/FullscreenCheckBox 
@onready var mute_on_focus_loss: FocusableCheckbox = $MarginContainer/VBoxContainer/MuteOnFocusLoss 
signal back_clicked()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fullscreen_check_box.button_pressed = SettingsController.is_fullscreen()
	mute_on_focus_loss.button_pressed = SettingsController.get_mute_on_focus_loss()
	
	AudioController.mute_on_focus_loose = SettingsController.get_mute_on_focus_loss()

func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	SettingsController.set_fullscreen(toggled_on)

func _on_back_button_pressed() -> void:
	back_clicked.emit()

func _on_mute_on_focus_loss_toggled(toggled_on: bool) -> void:
	SettingsController.set_mute_on_focus_loss(toggled_on)
	AudioController.mute_on_focus_loose = toggled_on

func init_focus():
	fullscreen_check_box.focus()
