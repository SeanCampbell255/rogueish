extends Area2D

var type: String = "coin"
var amount: int = 1
var game: Node2D

func _ready() -> void:
	game = get_node("/root/Game")

func _on_body_entered(body: Node2D) -> void:
	if(body is Player):
		game.grab_pickup(type, amount)
		queue_free()
