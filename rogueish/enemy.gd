class_name Enemy
extends RigidBody2D

@onready var hurtbox = $Hurtbox
@onready var timer = $Timer

var health = 10
var proximityDamage = 5
var canShoot = true
var shotCooldown = 2
var projectile = preload("res://projectile.tscn")
var target
var speed = 150
var isInProximity = false

func _ready() -> void:
	add_to_group("Enemies")
	hurtbox.body_entered.connect(_on_hurtbox_entered)
	hurtbox.body_exited.connect(_on_hurtbox_exited)
	target = get_target()
	
	if(canShoot):
		timer.wait_time = shotCooldown
		timer.start()

func _physics_process(delta: float) -> void:
	target = get_target()
	var direction = transform.origin.direction_to(target)
	position += speed * direction * delta

#CUSTOMS
func get_target() -> Vector2:
	return get_tree().get_first_node_in_group("Player").transform.origin

func take_damage(damage: int) -> void:
	health -= damage
	if(health < 1):
		queue_free()

func deal_proximity_damage(body: Player) -> void:
	isInProximity = true
	while(isInProximity):
		body.take_damage(proximityDamage)
		await get_tree().create_timer(0.25).timeout

func _on_hurtbox_entered(body):
	if(body is Player):
		deal_proximity_damage(body)

func _on_hurtbox_exited(body):
	if(body is Player):
		isInProximity = false

func _on_timer_timeout() -> void:
	var proj = projectile.instantiate()
	proj.set_properties(position, transform.origin.direction_to(target), 300, 1.5, 5, "Player")
	get_parent().add_child(proj)
