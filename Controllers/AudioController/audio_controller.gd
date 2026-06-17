extends Node

@export var mute: bool

@onready var music: AudioStreamPlayer2D = $Music
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var dash: AudioStreamPlayer2D = $Dash
@onready var collect: AudioStreamPlayer2D = $Collect
@onready var punch: AudioStreamPlayer2D = $Punch



func play_jump() -> void:
	if not mute:
		jump.play()

func play_dash() -> void:
	if not mute:
		dash.play()

func play_collect() -> void:
	if not mute:
		collect.play()

func play_punch() -> void:
	if not mute:
		punch.play()
