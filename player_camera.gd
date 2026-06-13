extends Camera2D
@onready var camera = $"."
@onready var targetZoom = Vector2(0.6,0.6)
#controls player camera movements (pan + zoom)
func _input(event: InputEvent) -> void:
	#pan
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			global_position -= (event.relative)/camera.zoom
	#changes target zoom (scroll-wheel mouse)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()
	#changes target zoom (Mac magic mouse)
	if event is InputEventPanGesture:
		var scroll_direction = sign(event.delta.y)
		if scroll_direction > 0:
			zoom_in()
		elif scroll_direction < 0:
			zoom_out()
func _process(delta: float) -> void:
	#interpolation for camera zoom so its smooth (and makes it so you zoom into where your mouse is)
	var mousePos = get_global_mouse_position()
	camera.zoom = camera.zoom.lerp(targetZoom, 10*delta)
	position += mousePos - get_global_mouse_position()

func zoom_in():
	if targetZoom < Vector2(1.2,1.2):
		targetZoom += Vector2(.05,.05)

func zoom_out():
	if targetZoom > Vector2(.5,.5):
		targetZoom -= Vector2(.05,.05)
