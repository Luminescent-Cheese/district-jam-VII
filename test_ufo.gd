extends Node2D

@export var cow_scene: PackedScene
@export var ufo_scene: PackedScene

func _ready() -> void:
	spawn_cow()
	spawn_ufo()

func spawn_cow() -> void:
	var new_cow = cow_scene.instantiate()
	var cow_location = $CowStartLocation
	new_cow.position = cow_location.position
	add_child(new_cow)

func spawn_ufo() -> void:
	var world_bounds = CoordsUtils.get_world_bounds(self)
	
	# random x position in viewport, at top (it will descend and search)
	var new_ufo = ufo_scene.instantiate()
	var random_x = randf_range(world_bounds.min_x, world_bounds.max_x)
	new_ufo.position = Vector2(random_x, world_bounds.min_y - 20)
	
	add_child(new_ufo)
