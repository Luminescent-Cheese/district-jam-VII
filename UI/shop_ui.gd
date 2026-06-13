extends Control
@onready var Game = $"../.."

signal attemptBuy(boughtObject: String)
func _on_carrot_cannon_button_down() -> void:
	attemptBuy.emit("CarrotCannon")


func _on_carrot_farm_button_down() -> void:
	attemptBuy.emit("CarrotFarm")
