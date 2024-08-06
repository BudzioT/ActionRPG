class_name Inventory
extends Node


"""----------------------- GLOBAL VARIABLES -----------------------"""
# References to nodes
@onready var inventory_ui: InventoryUi = $"../InventoryUI"
@onready var main_ui: MainUi = $"../MainUI"
@onready var combat: Combat = $"../Combat"
@onready var sprite: PlayerSprite = $"../Sprite"

# Inventory variables
@export_category("Inventory")
# Currently existing items in the inventory
@export var items: Array[InventoryItem] = []

# Amount of occupied inventory slots
var occupied_slots: int = 0

# Pickup item scene
const PICKUP_ITEM_SCENE: PackedScene = preload("res://Scenes/Objects/pick_up_item.tscn")


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the inventory"""
	# Connect the right signal to equip an item
	inventory_ui.equip_item.connect(_item_equipped)
	
	# Also connect a singal to drop an item
	inventory_ui.drop_item.connect(_item_dropped)

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
		
		# Increase occupied slots count
		occupied_slots += 1
		
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
		
		# Update the amount of occupied slots
		occupied_slots += 1
		
func _item_equipped(index: int, slot_type: String) -> void:
	"""Equip item with the given index"""
	# Get the right item
	var item = items[index]
	
	# Equip it in main UI
	main_ui.equip_item(item, slot_type)
	# Set it as the weapon which player's currently attacking with
	combat.set_weapon(item.weapon_item, slot_type)
	
func _item_dropped(index: int):
	"""Drop an item with the given index"""
	# Clear the given slot
	_clear_slot(index)
	# Drop this item onto the ground
	_drop_item_ground(index)
	
func _clear_slot(index: int):
	"""Clear an inventory slot with the given index"""
	# Decrease occupied slot count
	occupied_slots -= 1
	
	# Clear the slot at UI level
	inventory_ui.clear_slot(index)
	
func _drop_item_ground(index: int):
	"""Drop item with the given index, onto ground"""
	# Get the dropped item
	var item_to_drop = items[index]
	
	# Instantiate a pickup item scene
	var item_dropped = PICKUP_ITEM_SCENE.instantiate() as PickUpItem
	
	# Set correct data of the dropped item
	item_dropped.inventory_item = item_to_drop
	item_dropped.amount = item_to_drop.amount
	
	# Add item into the scene
	get_tree().root.get_node("Main/Items").add_child(item_dropped)
	
	# Disable items collisions, place it onto the player's position at first
	item_dropped.disable_collisions()
	item_dropped.global_position = get_parent().global_position
	
	# Get direction of dropping item
	var drop_direction = sprite.drop_direction
	# If item is dropped horizontally, randomize its vertical direction
	if drop_direction.y == 0:
		drop_direction.y = randf_range(-1, 1)
	# Otherwise randomize the horizontal direction
	else:
		drop_direction.x = randfn(-1, 1)
