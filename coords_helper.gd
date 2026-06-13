class_name CoordsUtils
extends Node

static func get_world_bounds(node: CanvasItem) -> Dictionary:
	var canvas_transform = node.get_canvas_transform()
	var viewport_rect = node.get_viewport_rect()
	
	var top_left_global = -canvas_transform.origin / canvas_transform.get_scale()
	var visible_size_global = viewport_rect.size / canvas_transform.get_scale()
	
	return {
		"min_x": top_left_global.x,
		"max_x": top_left_global.x + visible_size_global.x,
		"min_y": top_left_global.y,
		"max_y": top_left_global.y + visible_size_global.y
	}

static func get_random_x_in_world(node: CanvasItem) -> int:
	var world_bounds = get_world_bounds(node)
	return randi_range(world_bounds.min_x, world_bounds.max_x)
