@tool
extends VBoxContainer
class_name FocusableLabel

signal text_changed(text: String)
@export var text: String = '':
	get: return text
	set(value): 
		text = value
		text_changed.emit(value)


@onready var label: Label = $Label
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	_update_label(text)

func _enter_tree() -> void:
	text_changed.connect(_update_label)
	
func _exit_tree() -> void:
	text_changed.disconnect(_update_label)
	
func _update_label(text: String):
	label.text = text
	
func focus():
	color_rect.visible = true
	
func unfocus():
	color_rect.visible = false
