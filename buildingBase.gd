extends CharacterBody2D

@export var xPos = 99999
func _physics_process(delta: float) -> void:
	if xPos == 99999:
		_buildPlace()

func _buildPlace() -> void:
	position = Vector2(get_global_mouse_position().x,0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		xPos = position.x
