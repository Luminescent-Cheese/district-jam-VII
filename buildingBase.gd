extends CharacterBody2D

@export var xPos = 99999
@export var cost = 0
func _physics_process(delta: float) -> void:
	if xPos == 99999:
		_buildPlace()
	else:
		$Pivot.look_at(get_global_mouse_position())
		
		#all stuff tower does

func _buildPlace() -> void:
	position = Vector2(get_global_mouse_position().x,0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		xPos = position.x
