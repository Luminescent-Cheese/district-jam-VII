extends Node2D
@onready var cooldown = $"../Cooldown"
@onready var farmSprite = $"../CropGrowthSprites"
@onready var growthStage = 0
@onready var startTimer = true
func _ready() -> void:
	farmSprite.animation = "Carrots"
func _process(delta: float) -> void:
	if $"..".xPos != 99999:
		if growthStage < 4 and startTimer:
			cooldown.start()
			startTimer = false
		farmSprite.frame = growthStage


func _on_cooldown_timeout() -> void:
	growthStage += 1
	startTimer = true

func _on_clickable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("leftClick"):
		print(growthStage)
		if growthStage ==4:
			growthStage = 0
