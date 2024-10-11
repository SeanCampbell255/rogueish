extends Control

@onready var player = %Player

var offset = Vector2(0, -300)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_menu"):
		if (visible):
			unpause()
		else:
			pause()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	unpause()

#CUSTOMS
func pause() -> void:
	global_position = player.global_position + offset
	visible = true
	get_tree().paused = true

func unpause() -> void:
	visible = false
	get_tree().paused = false

#RECIEVERS
func _on_resume_pressed() -> void:
	unpause()

func _on_quit_pressed() -> void:
	get_tree().quit()
