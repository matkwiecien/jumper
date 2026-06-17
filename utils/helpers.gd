extends Node2D
class_name Utility

const TOP_EDGE = 1
const RIGHT_EDGE = 2
const BOTTOM_EDGE = 3
const LEFT_EDGE = 4


func get_random_position_on_top_edge(offset: Vector2) -> Vector2:
	var viewport_size = get_viewport_rect().size
	randomize()
	return Vector2(randf_range(-viewport_size.x/2 - offset.x, viewport_size.x/2 + offset.x), get_top_line()  - offset.y)

func get_random_position_on_edge(offset: Vector2):	
	randomize()
	var side = int(round(randf_range(0.51, 4.49)))
	
	if side == TOP_EDGE: #
		return Vector2(get_random_x_with_offset(offset.x), get_top_line()  - offset.y)
	if side == BOTTOM_EDGE: #
		return Vector2(get_random_x_with_offset(offset.x), get_bottom_line()  + offset.y) 
	if side == RIGHT_EDGE:
		return Vector2(get_right_line()  + offset.x, randf_range(get_top_line() - offset.y,  get_bottom_line()  + offset.y))
	if side == LEFT_EDGE:
		return Vector2(get_left_line()  - offset.x, randf_range(get_top_line()  - offset.y,  get_bottom_line()  + offset.y))

func get_bottom_line():
	var viewport_size = get_viewport_rect().size
	return viewport_size.y
	
func get_top_line():
	return 0
	
func get_left_line():
	return 0
		
func get_right_line():
	var viewport_size = get_viewport_rect().size
	return viewport_size.x

func get_random_x_with_offset(offset: float):
	return randf_range(get_left_line() - offset, get_right_line() + offset)
	
func get_random_x():
	return randf_range(get_left_line(), get_right_line())

func get_random_y():
	return randf_range(get_bottom_line(), get_top_line())
