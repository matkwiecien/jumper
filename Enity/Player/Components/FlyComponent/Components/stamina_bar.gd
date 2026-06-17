extends ProgressBar

@export var flyComponent: FlyComponent

func _ready() -> void:
	flyComponent.max_stamina_change.connect(on_max_stamina_change)
	flyComponent.stamina_change.connect(on_stamina_change)
	
	max_value = flyComponent.max_stamina
	value = flyComponent.stamina

func on_max_stamina_change(max_stamina: float):
	max_value = max_stamina
	
func on_stamina_change(stamina: float):
	value = stamina
