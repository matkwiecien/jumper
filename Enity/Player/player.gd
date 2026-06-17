class_name Player extends CharacterBody2D



@export var max_run_speed: float = 120.0
@export var max_air_speed: float = 120.0

@export var ground_acceleration: float = 700
@export var ground_reduction: float = 600.0
@export var air_acceleration: float = 600.0
@export var air_reduction: float = 300.0

@export var peak_gravity = 300
@export var fall_gravity = 300
@export var max_fall_speed = 300

var direction = 1

signal lifes_change(lifes: int)
var lifes: int = 1:
	get: return lifes
	set(value):
		lifes = value
		lifes_change.emit(lifes)
		if lifes <= 0:
			player_dead.emit()
		
	
signal player_dead()

var disabled_moving: bool = false

@onready var fly_component: FlyComponent = $FlyComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var intouchable_timer: Timer = $Timers/IntouchableTimer
		
func _physics_process(delta: float) -> void:	
	
	animated_sprite_2d.flip_h = direction == 1
	
	if not disabled_moving:
		_apply_move(delta)
		
	_apply_gravity(delta)	
	
	if velocity.x > 0:
		direction = 1
	elif  velocity.x < 0:
		direction = -1
				
	move_and_slide()

func _apply_gravity(delta: float):
	if 	velocity.y < 0:	
		velocity.y = move_toward(velocity.y, 0, peak_gravity * delta) 
	else:
		velocity.y =  move_toward(velocity.y, max_fall_speed, fall_gravity * delta)

func _apply_move(delta: float):
	var is_moving = not is_zero_approx(velocity.x)
	var moving_direction = sign(velocity.x)
	
	var horizontal_direction = Input.get_axis("move_left", 'move_right')
	var want_stop = horizontal_direction == 0
	var want_move = !want_stop
	var want_turn_back = moving_direction != horizontal_direction
	var want_continue_move = moving_direction == horizontal_direction

	var decceleration = get_decceleration()
	var acceleration = get_acceleration()
	
	var max_speed = max_run_speed
	if not is_on_floor():
		max_speed = max_air_speed
	if want_stop and is_moving:
		var delta_speed = decceleration * delta
		velocity.x = move_toward(velocity.x, 0, delta_speed)
	
	
	if want_turn_back and is_moving:
		var delta_speed = acceleration * delta
		velocity.x = move_toward(velocity.x, max_speed * horizontal_direction, delta_speed)
		
	
	if want_move and not is_moving:
		var delta_speed = acceleration * delta
		velocity.x = move_toward(velocity.x, max_speed * horizontal_direction, delta_speed)
		
		
	if want_continue_move and is_moving:
		var delta_speed = acceleration * delta
		velocity.x = move_toward(velocity.x, max_speed * horizontal_direction, delta_speed)

func get_acceleration() -> float:
	if is_on_floor():
		return ground_acceleration
		
	return air_acceleration
	
func get_decceleration() -> float:
	if is_on_floor():
		return ground_reduction
		
	return air_reduction

func _on_player_out_of_screen():
	player_dead.emit()
	
func hit():
	lifes -= 1
	intouchable_timer.start()
	set_collision_layer_value(1, false)
	animated_sprite_2d.play("idle_ghost")
	
func add_life():
	lifes += 1
	
func _on_player_intouchable_timeout():
	set_collision_layer_value(1, true)
	animated_sprite_2d.play("idle")
	
func disable_move():
	disabled_moving = true
	fly_component.disable_move()
	velocity.x = 0

func enable_move():
	disabled_moving = false
	fly_component.enable_move()
