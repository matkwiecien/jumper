extends Control

@export var game_scene: StringName = &""
@onready var new_game_btn: TextureButton = $MarginContainer/VBoxContainer/MarginContainer/PanelContainer/VBoxContainer/NewGameBtn

func _ready() -> void:
	new_game_btn.grab_focus()
	
func _on_new_game_btn_pressed() -> void:
	SaveGameController.load_last_saved_stage = false
	SceneController.load_scene(game_scene)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_btn_pressed() -> void:
	SaveGameController.load_last_saved_stage = true
	SceneController.load_scene(game_scene)
