class_name Bonus extends Area2D

var direction = Vector2(1, 0)
@export var speed: float = 100
var speed_multiplier = 1

func collect_audio_effect():
	AudioController.play_collect()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_on_collect(body as Player)
		collect_audio_effect()
		queue_free()
		
func _on_collect(_player: Player):
	pass

func _enter_tree() -> void:
	body_entered.connect(_on_body_entered)
	

func _exit_tree() -> void:
	body_entered.disconnect(_on_body_entered)
