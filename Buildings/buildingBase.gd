extends CharacterBody2D

@onready var cooldown = $Cooldown
const BULLET = preload("res://bullet.tscn")

@export var bulletSpawn:Marker2D
@onready var xPos = 99999
@export var cost: float
enum bullet{Carrot}
@export var bulletType:bullet
@export var fireRate: float

var canFire:bool

func _ready() -> void:
	canFire = true
	cooldown.wait_time = fireRate

func _physics_process(delta: float) -> void:
	if xPos == 99999:
		_buildPlace()
	else:
		$Pivot.look_at(get_global_mouse_position())
		if canFire:
			fireBullet()
			canFire = false
			cooldown.start()
			
		
		#all stuff tower does

func _buildPlace() -> void:
	position = Vector2(get_global_mouse_position().x,0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		xPos = position.x
		#placement particles
		$PlacementParticles.emitting = true

func fireBullet()-> void:
	var newBullet = BULLET.instantiate()
	newBullet.position = bulletSpawn.global_position
	#replace below with proper position later
	newBullet.direction = (bulletSpawn.global_position).direction_to(get_global_mouse_position())
	add_sibling(newBullet)


func _on_cooldown_timeout() -> void:
	canFire = true
