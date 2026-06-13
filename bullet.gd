extends CharacterBody2D
@export var direction: Vector2
@export var SPEED = 600

func _ready() -> void:
	look_at(global_position + direction)
func _physics_process(delta: float) -> void:
	velocity = direction*SPEED
	move_and_slide()


func _on_delete_timer_timeout() -> void:
	queue_free()
