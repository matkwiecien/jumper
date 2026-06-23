extends Control
class_name MainMenu

@export var game_scene: StringName = &""

@onready var new_game_btn: TextureButton = $MarginContainer/MainMenuContainer/MarginContainer/PanelContainer/VBoxContainer/NewGameBtn
@onready var main_menu_container: VBoxContainer = $MarginContainer/MainMenuContainer
@onready var option_panel_container: VBoxContainer = $MarginContainer/OptionPanelContainer
@onready var option_panel: PanelContainer = $MarginContainer/OptionPanelContainer/MarginContainer2/OptionPanel
@onready var continue_btn: TextureButton = $MarginContainer/MainMenuContainer/MarginContainer/PanelContainer/VBoxContainer/ContinueBtn

func _ready() -> void:
	if SaveGameController.has_saved_game():
		continue_btn.grab_focus()
		continue_btn.show()
	else:
		new_game_btn.grab_focus()
	

	
func _on_new_game_btn_pressed() -> void:
	SaveGameController.load_last_saved_stage = false
	SceneController.load_scene(game_scene)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_btn_pressed() -> void:
	SaveGameController.load_last_saved_stage = true
	SceneController.load_scene(game_scene)


func _on_options_btn_pressed() -> void:
	main_menu_container.hide()
	option_panel_container.show()
	option_panel.init_focus()


func _on_option_panel_back_clicked() -> void:
	main_menu_container.show()
	init_focus()
	option_panel_container.hide()


func init_focus():
	new_game_btn.grab_focus()
