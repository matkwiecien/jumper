extends Control

@onready var lost_life_icon: TextureRect = $FailedFlowerIcon 
@onready var success_life_icon: TextureRect = $SuccessFlowerIcon 

var is_success: bool = false :
	get: return is_success
	set(value):
		is_success = value
		success_life_icon.visible = value
		lost_life_icon.visible = not value
