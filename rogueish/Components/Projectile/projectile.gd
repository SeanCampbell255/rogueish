extends Area2D

@onready var timer: Timer = $"Timer"

var direction = Vector2.RIGHT
var speed = 300
var duration = 1.5
var damage = 5
var targetGroup = "Enemies"

func _process(delta: float) -> void:
	position += speed * direction * delta

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	timer.wait_time = duration
	timer.start()

#CUSTOMS
func set_properties(i_position, i_direction, i_speed, i_duration, i_damage, i_targetGroup):
	global_position = i_position
	direction = i_direction
	speed = i_speed
	duration = i_duration
	damage = i_damage
	targetGroup = i_targetGroup

#RECIEVERS
func _on_body_entered(body: Node) -> void:
	if(body.is_in_group(targetGroup)):
		body.take_damage(damage)

func _on_timer_timeout() -> void:
	queue_free()
