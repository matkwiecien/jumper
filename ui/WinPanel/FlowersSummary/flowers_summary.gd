extends HBoxContainer


var life_count = 3


func _update_flower(flowers: int) -> void:
	var childrens = get_children()
	for child in childrens:
		child.is_success = false
	
	for i in flowers:
		var child = childrens[i]
		child.is_success = true
