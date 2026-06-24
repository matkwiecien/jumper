extends Node


@export var players_default_lifes: int = 3
@export var player: Player
@export var stage_start_index: int = 0
@export var wave_start_index: int = 0

@onready var game_node: Node2D = $GameNode
@onready var win_panel: Control = $CanvasLayer/Control/WinPanel
@onready var stage_manager: StageManager = $GameNode/StageManager

func _ready() -> void:
	
	if SaveGameController.load_last_saved_stage:
		_load_last_saved_game()
	else:
		_load_new_game()

func _load_new_game() -> void:
	stage_manager.load_stage_by_index(stage_start_index, wave_start_index)
	player.lifes = players_default_lifes
	
func _load_last_saved_game() -> void:
	var saved_game = SaveGameController.load_game()
	player.lifes = saved_game.lifes	
	stage_manager.load_stage_by_index(saved_game.stage_index, 0)
	
func _on_stage_end():
	stage_manager.next_stage()
	SaveGameController.save_game(stage_manager.current_wave_index, player.lifes)

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
