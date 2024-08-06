class_name Inventory
extends Node


"""----------------------- GLOBAL VARIABLES -----------------------"""
# References to nodes
@onready var inventory_ui: InventoryUi = $"../InventoryUI"
@onready var main_ui: MainUi = $"../MainUI"
@onready var combat: Combat = $"../Combat"

# Inventory variables
@export_category("Inventory")
# Currently existing items in the inventory
@export var items: Array[InventoryItem] = []


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the inventory"""
	# Connect the right signal to equip an item
	inventory_ui.equip_item.connect(_item_equipped)

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
	# Otherwise just add it to the inventory
	else:
		items.append(item)
		# Update the inventory UI
		inventory_ui.add_item(item)
		
func add_multiple_inventory_item(item: InventoryItem, amount: int) -> void:
	"""Add an item to the inventory if its stackable"""
	# Set the item index to -1 at first, to indicate it not being in the inventory
	var item_index: int = -1
	# Go through each item and find the first index of the specified item
	for index in items.size():
		if items[index] != null and items[index].name == item.name:
			item_index = index
			
	# If item already exists, handle stacking
	if item_index != -1:
		# Get the found item
		var inventory_item: InventoryItem = items[item_index]
		
		# If stack isn't overflow after adding the amount, add it
		if inventory_item.amount + amount <= item.max_amount:
			inventory_item.amount += amount
			# Update the real item, based off the copy
			items[item_index] = inventory_item
			# Update the ui amount of this item
			inventory_ui.update_amount(item.amount, item_index)
		
		# Otherwise move the item to the next slot
		else:
			# Calculate the difference - how much to move to the next slot
			var amount_difference: int = inventory_item.amount + amount - item.max_amount
			
			# Duplicate the inventory item 
			var next_inventory_item: InventoryItem = inventory_item.duplicate(true)
			
			# Fill up the last item slot to a max amount
			inventory_item.amount = item.max_amount
			# Update the ui part of it
			inventory_ui.update_amount(item.max_amount, item_index)
			
			# Fill the new slot with calculated difference
			next_inventory_item.amount = amount_difference
			# Add it to the current items
			items.append(next_inventory_item)
			
			# Add the new item to the inventory UI
			inventory_ui.add_item(next_inventory_item)
			
	# Otherwise	just add this item plainly
	else:
		item.amount = amount
		items.append(item)
		
		# Update the inventory UI
		inventory_ui.add_item(item)
		
func _item_equipped(index: int, slot_type: String):
	"""Equip item with the given index"""
	# Get the right item
	var item = items[index]
	
	# Equip it in main UI
	main_ui.equip_item(item, slot_type)
	# Set it as the weapon which player's currently attacking with
	combat.set_weapon(item.weapon_item, slot_type)
