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
	var canvas_transform = get_canvas_transform()
	var viewport_rect = get_viewport_rect()
	
	var top_left_global = -canvas_transform.origin / canvas_transform.get_scale()
	var visible_size_global = viewport_rect.size / canvas_transform.get_scale()
	
	var min_x = top_left_global.x
	var max_x = top_left_global.x + visible_size_global.x
	var min_y = top_left_global.y
	var max_y = top_left_global.y + visible_size_global.y
	
	# random x position in viewport, at top (it will descend and search)
	var new_ufo = ufo_scene.instantiate()
	var random_x = randf_range(min_x, max_x)
	new_ufo.position = Vector2(random_x, min_y)
	
	var cow_location = $CowStartLocation
	new_ufo.position = Vector2(cow_location.position.x, min_y)
	
	add_child(new_ufo)
