extends Node2D
class_name FlyComponent

@export var fly_acceleration: float = 400
@export var fly_max_speed: float = 300


@export var boost_acceleration: float = 5000


@export var player: Player

var disabled_moving: bool = false

func _physics_process(delta: float) -> void:
	if _can_fly():
		player.velocity.y = -fly_max_speed
		player.animated_sprite_2d.stop()
		player.animated_sprite_2d.play("fly")

		

func _can_fly() -> bool:	
	var fly_pressed = Input.is_action_just_pressed("fly")
	return fly_pressed and not disabled_moving

func _can_boost_down() -> bool:	
	var fly_pressed = Input.is_action_just_pressed("boost_down")
	return fly_pressed 
	
func disable_move():
	disabled_moving = true
	
func enable_move():
	disabled_moving = false
