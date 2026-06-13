extends CharacterBody2D

@onready var beam_area: Area2D = $Beam2D

@export var cow_in_beam: CharacterBody2D = null

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if !cow_in_beam:
		scan_for_cow()
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:s
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func scan_for_cow():
	var cows_in_beam = beam_area.get_overlapping_bodies()
	for cow in cows_in_beam:
		if cow.name == "Cow":
			print("Found cow at position", cow.global_position)
			cow_in_beam = cow
			break
