extends CharacterBody2D
class_name Bullet

@export var direction: Vector2
@export var SPEED = 600
var bullet_type: GameGlobals.bullet


func _ready() -> void:
	look_at(global_position + direction)
func _physics_process(delta: float) -> void:
	velocity = direction*SPEED
	move_and_slide()


func _on_delete_timer_timeout() -> void:
	queue_free()
