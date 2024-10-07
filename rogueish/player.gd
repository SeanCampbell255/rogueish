class_name Player
extends CharacterBody2D

@export var speed = 400

@onready var attackTimer = $AttackTimer

var health = 100
var movementInput = Vector2.ZERO
var projectile = preload("res://projectile.tscn")
var target: Enemy

func _physics_process(_delta: float) -> void:
	player_movement()

func _ready() -> void:
	attackTimer.start()
	add_to_group("Player")

#CUSTOMS
func attack() -> void:
	var proj = projectile.instantiate()
	proj.set_properties(position, transform.origin.direction_to(get_target()), 300, 1.5, 5, "Enemies")
	get_parent().add_child(proj)

func get_movementInput() -> void:
	movementInput.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	movementInput.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

func get_target() -> Vector2:
	var closest = Vector2(99999.0, 999999.0)
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var enemyPosition = enemy.transform.origin
		if(transform.origin.distance_to(enemyPosition) < transform.origin.distance_to(closest)):
			closest = enemyPosition
	return closest

func player_movement() -> void:
	get_movementInput()
	
	if movementInput == Vector2.ZERO:
		velocity = movementInput
	else:
		velocity = movementInput * speed
	
	move_and_slide()

func take_damage(i_damage: int) -> void:
	health -= i_damage
	print(health)
	if(health < 1):
		queue_free()

#RECIEVERS
func _on_attack_timer_timeout() -> void:
	attack()
