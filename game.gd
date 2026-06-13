extends Node2D

const COW_SCENE = preload("res://cow.tscn")
const UFO_SCENE = preload("res://ufo.tscn")

@onready var player_camera = get_node("/root/Game/PlayerCamera")

enum bullet{Carrot}

func _ready() -> void:
	spawn_cows(5)
	spawn_ufo()

func spawn_cows(num_cows: int) -> void:
	for i in range(num_cows):	
		var new_cow = COW_SCENE.instantiate()
		var random_x = CoordsUtils.get_random_x_in_camera(player_camera)
		var cow_location = Vector2(random_x, 0)
		new_cow.position = cow_location
		new_cow.name = "Cow %s" % i
		new_cow.connect("abducted", cow_abducted)
		add_child(new_cow)

func spawn_ufo() -> void:
	var bounds = CoordsUtils.get_camera_bounds(player_camera)
	var _random_x = CoordsUtils.get_random_x_in_camera(player_camera)
	
	# random x position in viewport, at top (it will descend and search)
	var new_ufo = UFO_SCENE.instantiate()
	new_ufo.position = Vector2(0, bounds.min_y)
	
	add_child(new_ufo)

func cow_abducted(cow, ufo):
	print("%s was abducted by %s" % [cow.name, ufo.name])
	cow.queue_free()
