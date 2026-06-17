class_name Ladybird extends Killer

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if position.x < 370:
		direction.x = 1
	else:
		direction.x = -1

func _physics_process(delta: float) -> void:	
	super(delta)

	
	if global_position.x < 16:
		direction.x = 1
	elif global_position.x > 624:
		direction.x = -1
	
	animation.flip_h = direction.x < 0
	
