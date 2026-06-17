extends HBoxContainer

var success_icons: Array[Node2D] = []
var fails_icons: Array[Node2D] = []

func _update_lifes(lifes: int) -> void:
	var childrens = get_children()
	for child in childrens:
		child.is_success = false
	
	for i in lifes:
		var child = childrens[i]
		child.is_success = true
