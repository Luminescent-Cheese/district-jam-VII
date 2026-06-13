extends CharacterBody2D

enum CowState { MOVE, EAT, BEAM_UP, FALL}
var state = CowState.EAT
var direction = Vector2.ZERO
var abducted_by_ufo = null

const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)

func _ready() -> void:
	direction = [RIGHT, LEFT].pick_random()
	if (direction == LEFT):
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.animation = "rest"

func _process(_delta: float) -> void:
	if state == CowState.BEAM_UP:
		beam_up()

func abducted_by(ufo) -> void:
	state = CowState.BEAM_UP
	abducted_by_ufo = ufo
	$AnimatedSprite2D.animation = "panic"
	$AnimatedSprite2D.play()

func beam_up() -> void:
	direction = Vector2(0,-1)
	velocity = direction * 85
	move_and_slide()
