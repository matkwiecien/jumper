extends Node
class_name GameStateManager

enum GAME_STATE {
	WAIT_FOR_PLAYER_TO_START,
	WAIT_FOR_FLOWER_WILT,
	WAIT_FOR_STAGE_END,
	WAIT_FOR_ALL_ENEMY_BE_DESTROYED,
	WAIT_FOR_FLOWER_GROW,
	WAIT_FOR_PLAYER_TO_LAND_ON_FLOWER,
	WAIT_FOR_STAGE_PREPATIONS_END,
}

@onready var stage_manager: StageManager = $"../StageManager"
@onready var enemy_wave_generator: EnemyWaveGenerator = $"../EnemyWaveGenerator"
@onready var win_panel: Control = $"../../CanvasLayer/Control/WinPanel"
@onready var player: Player = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


var game_state: GAME_STATE = GAME_STATE.WAIT_FOR_PLAYER_TO_START

func is_waiting_for_player_to_start():
	return game_state == GAME_STATE.WAIT_FOR_PLAYER_TO_START 

func is_waiting_for_flower_to_grow():
	return game_state == GAME_STATE.WAIT_FOR_FLOWER_GROW 

func is_waiting_for_flower_to_wilt():
	return game_state == GAME_STATE.WAIT_FOR_FLOWER_WILT  
	
func is_waiting_for_player_to_land_on_flower():
	return game_state == GAME_STATE.WAIT_FOR_PLAYER_TO_LAND_ON_FLOWER  
	
	
func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("fly") and is_waiting_for_player_to_start():
		game_state = GAME_STATE.WAIT_FOR_STAGE_END
		stage_manager.start_stage()
		animated_sprite_2d.hide()

		
		
func _process(_delta: float) -> void:
	if game_state == GAME_STATE.WAIT_FOR_STAGE_END and stage_manager.is_stopped():
		_on_stage_stopped();
		
	if game_state == GAME_STATE.WAIT_FOR_ALL_ENEMY_BE_DESTROYED and enemy_wave_generator.is_all_enemy_removed():
		_on_all_enemy_destroyed()
		
func _on_stage_stopped():

	
	game_state = GAME_STATE.WAIT_FOR_ALL_ENEMY_BE_DESTROYED
	if not enemy_wave_generator.is_all_enemy_removed():		
		enemy_wave_generator.start_remove_enemy_timeout()
		return
	_on_all_enemy_destroyed()
	
func _on_all_enemy_destroyed():
	game_state = GAME_STATE.WAIT_FOR_STAGE_PREPATIONS_END
	player.disable_move()
	win_panel.show()
	
func _on_next_stage_clicked():
	stage_manager.next_stage()
	game_state = GAME_STATE.WAIT_FOR_PLAYER_TO_START
	player.enable_move()
	win_panel.hide()
	animated_sprite_2d.show()
