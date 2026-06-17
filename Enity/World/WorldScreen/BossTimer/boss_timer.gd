extends ProgressBar
class_name  BossTimer

var survive_time: float

signal timeout()

func _ready() -> void:
	set_process(false)	

func load_boss_settings(boss: BossAvailability):
	survive_time = boss.boss_time
	max_value = survive_time
	value = survive_time
	set_process(true)
	visible = true
	
func _process(delta: float) -> void:
	survive_time -= max(0, delta)
	value = survive_time
	
	if survive_time < 0:
		timeout.emit()
		set_process(false)
		visible = false
		
	
	
