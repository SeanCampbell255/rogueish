extends Node2D

var enemy = preload("res://Components/Enemy/enemy.tscn")
@onready var path: PathFollow2D = $Player/Path2D/PathFollow2D
@onready var spawnPoint: Marker2D = $Player/Path2D/PathFollow2D/Marker2D
@onready var timer: Timer = $SpawnTimer

var coins = 0

func _ready() -> void:
	timer.wait_time = 1
	timer.start()

func grab_pickup(type: String, amount: int) -> void:
	if (type == "coin"):
		coins += amount
		print(coins)

func _on_spawn_timer_timeout() -> void:
	print("spawn")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	path.progress = rng.randf_range(0, 4040)
	
	var instance = enemy.instantiate()
	instance.global_position = spawnPoint.global_position
	add_child(instance)
