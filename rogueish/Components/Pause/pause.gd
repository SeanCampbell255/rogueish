extends Control

@onready var player = %Player

var offset = Vector2(0, -300)

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_menu"):
		global_position = player.global_position + offset
		visible = true
		get_tree().paused = true

func _ready() -> void:
	visible = false
