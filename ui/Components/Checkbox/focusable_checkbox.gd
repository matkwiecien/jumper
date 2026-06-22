@tool
extends HBoxContainer
class_name FocusableCheckbox

signal text_change(value: String)
signal button_pressed_change(value: String)
signal toggled(toggled_on: bool)

@export var text: String = '':
	get: return text
	set(value):
		text = value
		text_change.emit(value)
		
@export var button_pressed: bool:
	get: return button_pressed
	set(value):
		button_pressed = value
		button_pressed_change.emit(value)
		
@onready var focusable_label: FocusableLabel = $FocusableLabel
@onready var check_box: CheckBox = $CheckBox

func _ready() -> void:
	focusable_label.text = text
	check_box.button_pressed = button_pressed

func _enter_tree() -> void:
	text_change.connect(_on_label_update)
	button_pressed_change.connect(_on_button_pressed_update)
	
func _exit_tree() -> void:
	text_change.disconnect(_on_label_update)
	button_pressed_change.disconnect(_on_button_pressed_update)

func _on_label_update(value: String):
	focusable_label.text = value

func _on_button_pressed_update(button_pressed: bool):
	check_box.button_pressed = button_pressed

func _on_check_box_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)

func focus():
	check_box.grab_focus()
