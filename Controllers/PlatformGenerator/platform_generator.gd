extends Node2D

@export var leaf_scene: PackedScene

@export var camera: Camera2D

@export var platform_base_speed = 50
@export var platform_speed_variety: float = 25

@export var margin_bottom: float = 8
@export var margin_top: float = 32

@export var row_height: int = 32

var plattform_count = 15

var slots_y: Array[float] = []

var leafs: Array[Leaf] = []



func _ready() -> void:
	return
	calculate_slots()
	
	
	var start_x = -camera.get_viewport_rect().size.x/3
	var end_x = -2 * camera.get_viewport_rect().size.x/3
	
	for y in slots_y:
		create_platform_inside(start_x, end_x, y)
		

	start_x = camera.get_viewport_rect().get_center().x -camera.get_viewport_rect().size.x/3
	end_x = camera.get_viewport_rect().get_center().x  + camera.get_viewport_rect().size.x/3
	
	for y in slots_y:
		create_platform_inside(start_x, end_x, y)
		
	start_x = camera.get_viewport_rect().get_center().x  + camera.get_viewport_rect().size.x/3
	end_x = camera.get_viewport_rect().get_center().x  + 2 * camera.get_viewport_rect().size.x/3
	
	for y in slots_y:
		create_platform_inside(start_x, end_x, y)
		
func calculate_slots():
	var top = Helpers.get_top_line() + margin_top
	var bottom = Helpers.get_bottom_line() - margin_bottom
	
	var number_of_slots = (bottom - top ) / row_height
	
	for slot in number_of_slots:
		slots_y.append(top + slot * row_height)
	
func create_platform_inside(x_start: float, x_end: float, y_position: float):
	var leaf = (leaf_scene.instantiate() as Leaf)
	
	
	var leaf_position = Vector2(randf_range(x_start, x_end), y_position)
	var valid = false
	while not valid and leafs.size() > 0:		
		for l in leafs:
			if l.global_position.distance_squared_to(leaf_position) > 64:
				valid = true
				break
		leaf_position = Vector2(randf_range(x_start, x_end), y_position)
			
	leaf.global_position = leaf_position

	add_child(leaf)
	leafs.append(leaf)
	
func create_platform_with_flowers():
	var leaf = (leaf_scene.instantiate() as Leaf)
	var	start_x = camera.get_viewport_rect().get_center().x -camera.get_viewport_rect().size.x/3
	var end_x = camera.get_viewport_rect().get_center().x  + camera.get_viewport_rect().size.x/3
	
	var leaf_position = Vector2(randf_range(start_x, end_x), 0.0)
	
	leaf.global_position = leaf_position
	leaf.create_flower_bonus()
	
	add_child(leaf)
	leafs.append(leaf)
