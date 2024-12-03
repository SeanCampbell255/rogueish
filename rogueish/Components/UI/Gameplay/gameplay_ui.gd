extends CanvasLayer

@onready var coinLabel = %CoinLabel
@onready var xpBar = %XpBar

func _ready() -> void:
	xpBar.max_value = 5

# RECIEVERS

func _on_game_leveled_up(xpToLevel: int) -> void:
	xpBar.max_value = xpToLevel
	xpBar.value = 0

func _on_game_xp_gained(xp: int) -> void:
	xpBar.value += xp

func _on_game_coins_updated(coins: Variant) -> void:
	coinLabel.text = str(coins)
