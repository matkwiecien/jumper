class_name Killer extends Area2D

@export var speed: float = 100

var target_position: Vector2

func _physics_process(delta: float) -> void:	
	global_position = global_position.move_toward(target_position, speed * delta)

	if global_position.x < 0:
		queue_free()
		
func _play_collision_sound():
	AudioController.play_punch()
	
func _enter_tree() ->  void:
	body_entered.connect(_on_body_entered)	
			
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		(body as Player).hit()
		_play_collision_sound()
		
