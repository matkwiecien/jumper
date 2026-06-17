extends Control

signal next_button_pressed()

func _on_next_button_pressed() -> void:
	next_button_pressed.emit()
