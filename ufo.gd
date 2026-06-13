extends CharacterBody2D

@onready var hurtbox: Area2D = $HurtBox
@onready var beam_area: Area2D = $Beam2D
@onready var player_camera = get_node("/root/Game/PlayerCamera")

@export var cow_in_beam: CharacterBody2D = null

enum UfoAction { LOWER, MOVE, SCAN, ABDUCT_COW }
var current_action = null
var time_doing_action = 0.0

const MOVE_TIME_SECS = 0.5
const SCAN_TIME_SECS = 0.2

var moveed_same_direction_count = 0
var direction: Vector2 = Vector2.ZERO
const SPEED = 250.0


func _ready() -> void:
	current_action = UfoAction.LOWER
	$Beam2D.hide()

func _physics_process(delta: float) -> void:
	if cow_in_beam:
		center_on_cow(delta)
		return
	
	time_doing_action += delta
	
	if current_action == UfoAction.MOVE && time_doing_action > MOVE_TIME_SECS:
		current_action = UfoAction.SCAN
		time_doing_action = 0.0
		$Beam2D.show()
	elif current_action == UfoAction.SCAN && time_doing_action > SCAN_TIME_SECS:
		current_action = UfoAction.MOVE
		time_doing_action = 0.0
		if randf() < 0.2:
			# randomly change direction 20% of the time
			direction = Vector2(-direction.x, 0) 
		$Beam2D.hide()
	
	if current_action == UfoAction.SCAN:	
		scan_for_cow()
	elif current_action == UfoAction.MOVE:
		move()
	elif current_action == UfoAction.LOWER:
		lower()

func scan_for_cow():
	var cows_in_beam = beam_area.get_overlapping_bodies()	
	for cow in cows_in_beam:
		if cow.name.contains("Cow"):
			print("Found %s at position %s" % [cow.name, cow.global_position])
			cow.start_abduction(self)
			cow_in_beam = cow
			break

func center_on_cow(delta):
	var target_x = cow_in_beam.global_position.x
	global_position.x = lerp(global_position.x, target_x, 5 * delta)

func move():
	var bounds = CoordsUtils.get_camera_bounds(player_camera)
	if (global_position.x < bounds.min_x):
		direction = Vector2(1, 0)
	elif (global_position.x > bounds.max_x):
		direction = Vector2(-1, 0)
	elif direction == Vector2.ZERO:
		var random_horizontal = [-1, 1].pick_random()
		direction = Vector2(random_horizontal, 0)

	velocity = direction * SPEED
	move_and_slide()
	
func lower():
	var bounds = CoordsUtils.get_camera_bounds(player_camera)
	if (global_position.y > bounds.min_y + 500):
		current_action = UfoAction.SCAN
		time_doing_action = 0.0
		direction = Vector2.ZERO
		$Beam2D.show()
		return
	
	direction = Vector2(0, 1)
	velocity = direction * 200
	move_and_slide()


func _on_hurt_box_body_entered(bullet: Node2D) -> void:
	print("%s has been shot by %s!" % [self.name, bullet.name])
	bullet.queue_free()
