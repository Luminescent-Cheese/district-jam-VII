extends Node2D

const COW_SCENE = preload("res://cow.tscn")
const UFO_SCENE = preload("res://ufo.tscn")

func _ready() -> void:
	spawn_cows(5)
	spawn_ufo()

func spawn_cows(num_cows: int) -> void:
	var world_bounds = CoordsUtils.get_world_bounds(self)
	
	for i in range(num_cows):	
		var new_cow = COW_SCENE.instantiate()
		var cow_location = Vector2(CoordsUtils.get_random_x_in_world(self), world_bounds.max_y - 120)
		new_cow.position = cow_location
		new_cow.name = "Cow %s" % i
		add_child(new_cow)

func spawn_ufo() -> void:
	var world_bounds = CoordsUtils.get_world_bounds(self)
	
	# random x position in viewport, at top (it will descend and search)
	var new_ufo = UFO_SCENE.instantiate()
	new_ufo.position = Vector2(CoordsUtils.get_random_x_in_world(self), world_bounds.min_y - 20)
	
	add_child(new_ufo)
