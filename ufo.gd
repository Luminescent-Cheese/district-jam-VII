extends CharacterBody2D

@onready var beam_area: Area2D = $Beam2D

@export var cow_in_beam: CharacterBody2D = null

enum UfoAction { LOWER, MOVE, SCAN, ABDUCT_COW }
var current_action = null
var time_doing_action = 0.0

const MOVE_TIME_SECS = 0.5
const SCAN_TIME_SECS = 0.2

var direction: Vector2 = Vector2.ZERO
const SPEED = 250.0

func _ready() -> void:
	current_action = UfoAction.LOWER
	$Beam2D.hide()

func _physics_process(delta: float) -> void:
	if cow_in_beam:
		return
	
	time_doing_action += delta
	
	if current_action == UfoAction.MOVE && time_doing_action > MOVE_TIME_SECS:
		current_action = UfoAction.SCAN
		time_doing_action = 0.0
		$Beam2D.show()
		direction = Vector2.ZERO
	elif current_action == UfoAction.SCAN && time_doing_action > SCAN_TIME_SECS:
		current_action = UfoAction.MOVE
		time_doing_action = 0.0
		$Beam2D.hide()
		
	
	if current_action == UfoAction.SCAN:	
		scan_for_cow()
	elif current_action == UfoAction.MOVE:
		search()
	elif current_action == UfoAction.LOWER:
		lower()

func scan_for_cow():
	var cows_in_beam = beam_area.get_overlapping_bodies()	
	for cow in cows_in_beam:
		if cow.name.contains("Cow"):
			print("Found %s at position %s" % [cow.name, cow.global_position])
			cow.abducted_by(self)
			cow_in_beam = cow
			break

func search():
	var world_bounds = CoordsUtils.get_world_bounds(self)
	if (global_position.x < world_bounds.min_x):
		direction = Vector2(1, 0)
	elif (global_position.x > world_bounds.max_x):
		direction = Vector2(-1, 0)
	
	if direction == Vector2.ZERO:
		var random_horizontal = [-1, 1].pick_random()
		direction = Vector2(random_horizontal, 0)

	velocity = direction * SPEED
	move_and_slide()
	
func lower():
	var world_bounds = CoordsUtils.get_world_bounds(self)
	if (global_position.y > world_bounds.min_y + 40):
		current_action = UfoAction.SCAN
		time_doing_action = 0.0
		direction = Vector2.ZERO
		$Beam2D.show()
		return
	
	direction = Vector2(0, 1)
	velocity = direction * 100
	move_and_slide()
