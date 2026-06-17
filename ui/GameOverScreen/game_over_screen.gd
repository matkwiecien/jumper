extends Control

@export var game_scene: StringName = &""
@export var main_menu_scene: StringName = &""

@onready var try_again_button: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/TryAgainButton

func _ready() -> void:
	try_again_button.grab_focus()
	
func _on_main_menu_button_pressed() -> void:
	SceneController.load_scene(main_menu_scene)


func _on_try_again_button_pressed() -> void:
	SceneController.load_scene(game_scene)
