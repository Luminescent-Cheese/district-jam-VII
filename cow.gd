extends CharacterBody2D

signal abducted(cow, ufo)

enum CowState { MOVE, EAT, BEAM_UP, FALL}
var state = CowState.EAT
var direction = Vector2.ZERO
var ufo_abducting = null

const RIGHT = Vector2(1, 0)
const LEFT = Vector2(-1, 0)

@onready var sprite2D = $AnimatedSprite2D

func _ready() -> void:
	direction = [RIGHT, LEFT].pick_random()
	if (direction == LEFT):
		sprite2D.flip_h = true
	sprite2D.animation = "rest"
	sprite2D.play()

func _process(_delta: float) -> void:
	if !ufo_abducting and position.y < 0:
		state = CowState.FALL
	
	if state == CowState.BEAM_UP:
		beam_up()
	elif state == CowState.FALL:
		fall()

func start_abduction(ufo) -> void:
	state = CowState.BEAM_UP
	ufo_abducting = ufo
	sprite2D.animation = "panic"
	sprite2D.play()

func beam_up() -> void:
	direction = Vector2(0,-1)
	velocity = direction * 85
	move_and_slide()
	
	if ufo_abducting and position.y < ufo_abducting.position.y:
		abducted.emit(self, ufo_abducting)

func fall() -> void:
	pass
