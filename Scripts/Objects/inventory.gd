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
		
"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func add_item(item: InventoryItem, amount: int) -> void:
	"""Add an item to the inventory"""
	# If this type of item can be collected multiple times
	if amount and item.max_amount > 1:
		# Add certain amount of item
		add_multiple_inventory_item(item, amount)
		
func add_multiple_inventory_item(item: InventoryItem, amount: int) -> void:
	"""Add an item to the inventory if its stackable"""
	
