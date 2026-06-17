extends StaticBody2D
class_name Leaf

@export var bonus_probality: float = 0.05

var heal_bonus_scene = preload("res://Enity/Bonuses/HealBonus/HealBonus.tscn")
var flower_bonus_scene = preload("uid://clcqxphoes74")
var bonuses = [heal_bonus_scene]


var velocity = Vector2(30, 15)
var speed_multiplier = 1

var bottom_line: float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var marker_2d: Marker2D = $Marker2D

var flower: FlowerBonus
	
func create_flower_bonus():
	flower = flower_bonus_scene.instantiate() as FlowerBonus
	add_child(flower)
	flower.position = Vector2(0, -7.0)
	flower.speed = 0

func _physics_process(delta: float) -> void: 
	global_position += velocity * delta * speed_multiplier
	constant_linear_velocity = velocity * speed_multiplier
	
	global_position.x = wrapf(global_position.x, 0, 640)

	var current_camera_center = get_viewport().get_camera_2d().get_screen_center_position()
	if global_position.y > current_camera_center.y + get_viewport_rect().size.y/2:
		global_position.y -= 360
		if flower:
			flower.queue_free()
		
func _enter_tree() -> void:
	set_physics_process(false)

func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	set_physics_process(true)
