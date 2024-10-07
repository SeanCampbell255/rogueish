extends Node2D

var enemy = preload("res://enemy.tscn")
@onready var path: PathFollow2D = 
@onready var timer: Timer = $SpawnTimer

func _ready() -> void:
	timer.wait_time = 1
	timer.start()

func _on_spawn_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	enemy.instantiate()
