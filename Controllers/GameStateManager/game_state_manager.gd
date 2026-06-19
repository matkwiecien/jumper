extends Node
class_name GameStateManager

enum GAME_STATE {
	WAIT_FOR_PLAYER_TO_START,
	WAIT_FOR_STAGE_END,
	WAIT_FOR_ALL_ENEMY_BE_DESTROYED,
	WAIT_FOR_PLAYER_TO_LAND,
}

@onready var stage_manager: StageManager = $"../StageManager"
@onready var enemy_wave_generator: EnemyWaveGenerator = $"../EnemyWaveGenerator"
@onready var satge_completed_popup: Control = $"../../CanvasLayer/Control/SatgeCompletedPopup"
@onready var player: Player = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var delay_timer: Timer = $DelayTimer

var game_state: GAME_STATE = GAME_STATE.WAIT_FOR_PLAYER_TO_START

func is_waiting_for_player_to_start():
	return game_state == GAME_STATE.WAIT_FOR_PLAYER_TO_START 
	
func is_waiting_for_player_to_land():
	return game_state == GAME_STATE.WAIT_FOR_PLAYER_TO_LAND  
	
	
func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("fly") and is_waiting_for_player_to_start():
		game_state = GAME_STATE.WAIT_FOR_STAGE_END
		stage_manager.start_stage()
		animated_sprite_2d.hide()
		satge_completed_popup.hide()
		player.enable_move()
		
		
func _process(_delta: float) -> void:
	if game_state == GAME_STATE.WAIT_FOR_STAGE_END and stage_manager.is_stopped():
		_on_stage_stopped();
		
	if game_state == GAME_STATE.WAIT_FOR_ALL_ENEMY_BE_DESTROYED and enemy_wave_generator.is_all_enemy_removed():
		_on_all_enemy_destroyed()
		
	if game_state == GAME_STATE.WAIT_FOR_PLAYER_TO_LAND and player.is_on_floor() and delay_timer.is_stopped():
		_on_player_land_after_win()
		
func _on_stage_stopped():
	game_state = GAME_STATE.WAIT_FOR_ALL_ENEMY_BE_DESTROYED
	if not enemy_wave_generator.is_all_enemy_removed():		
		enemy_wave_generator.start_remove_enemy_timeout()
		return
	_on_all_enemy_destroyed()
	
func _on_all_enemy_destroyed():
	stage_manager.next_stage()
	game_state = GAME_STATE.WAIT_FOR_PLAYER_TO_LAND
	player.disable_move()
	satge_completed_popup.show()
	delay_timer.start()
	
func _on_player_land_after_win():	
	game_state = GAME_STATE.WAIT_FOR_PLAYER_TO_START
	player.enable_move()
	animated_sprite_2d.show()
	
	
