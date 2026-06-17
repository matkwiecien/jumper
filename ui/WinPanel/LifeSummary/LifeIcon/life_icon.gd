extends Control

@onready var lost_life_icon: TextureRect = $LostLifeIcon
@onready var success_life_icon: TextureRect = $SuccessLifeIcon

var is_success: bool = true :
	get: return is_success
	set(value):
		is_success = value
		success_life_icon.visible = value
		lost_life_icon.visible = not value
