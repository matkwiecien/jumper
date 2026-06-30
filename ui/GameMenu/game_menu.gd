extends MarginContainer

@onready var game_menu: VBoxContainer = $GameMenu

@onready var resume_button: Button = $GameMenu/MarginContainer/MenuPanel/VBoxContainer/ResumeButton
@onready var option_panel_container: VBoxContainer = $OptionPanelContainer
@onready var option_panel: OptionPanel = $OptionPanelContainer/MarginContainer2/OptionPanel

func init_menu_panel():
	resume_button.grab_focus()
	
func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("Menu"):		
		if game_menu.visible:
			hide_menu()
		elif option_panel_container.visible:
			_on_option_panel_back_clicked()
		else:
			show_menu()

func hide_menu():
	game_menu.visible = false
	get_tree().paused = false
	
func show_menu():
	game_menu.visible = true
	get_tree().paused = true
	init_menu_panel()


func _on_resume_button_pressed() -> void:
	hide_menu()

func _on_exit_pressed() -> void:
	SceneController.load_scene('uid://cme0qgmin6bc2')	
	get_tree().paused = false
	

func _on_options_pressed() -> void:
	option_panel_container.show()
	option_panel.init_focus()
	game_menu.visible = false
	
func _on_option_panel_back_clicked() -> void:
	game_menu.visible = true
	init_menu_panel()
	option_panel_container.visible = false
