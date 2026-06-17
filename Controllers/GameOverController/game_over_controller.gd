extends Node2D


@export var game_over_scene: StringName = &""

func _on_game_over():
	SceneController.load_scene(game_over_scene)
