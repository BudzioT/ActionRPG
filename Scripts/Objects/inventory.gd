class_name Inventory
extends Node


"""----------------------- GLOBAL VARIABLES -----------------------"""
@onready var inventory_ui: InventoryUi = $"../InventoryUI"


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _input(_event: InputEvent) -> void:
	"""Handle input events"""
	# If player opened the inventory, open its UI
	if Input.is_action_just_pressed("Inventory"):
		inventory_ui.toggle()
