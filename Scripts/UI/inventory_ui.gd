class_name InventoryUi
extends CanvasLayer


"""----------------------- SIGNALS -----------------------"""
signal equip_item(index: int, slot_type: String)
signal drop_item(index: int)


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Get reference to the container for items
@onready var item_container: GridContainer\
 	= $BackgrounContainer/Background/InventoryContainer/InventoryArea/ItemContainer

var INVENTORY_SLOT_SCENE: PackedScene \
	= preload("res://Scenes/Ui/inventory_slot.tscn")	

# Style of inventory UI related variables
@export_category("Style")
@export var size = 8
@export var columns = 4

"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the inventory UI"""
	# Set amount of columns in the inventory
	item_container.columns = columns
	
	# Create inventory slots in each grid cell
	for cell in size:
		# Create an inventory slot and add it to the container
		var inventory_slot = INVENTORY_SLOT_SCENE.instantiate()
		item_container.add_child(inventory_slot)
		
		# Connect the right singal to equip an item
		inventory_slot.equip_item.connect(func(slot_type: String): \
			equip_item.emit(cell, slot_type))
		# Also connect sygnal to drop an item
		inventory_slot.drop_item.connect(func():\
			drop_item.emit(cell))

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func toggle() -> void:
	"""Toggle the inventory UI"""
	visible = !visible
	
func add_item(item: InventoryItem) -> void:
	"""Add item to the UI part of the inventory"""
	# Get all the empty slots of the inventory
	var slots = item_container.get_children().filter(func(slot): return slot.empty)
	# Save the first empty one, and add an item to it
	var first_empty = slots.front() as InventorySlot
	first_empty.add_item(item)
	
func update_amount(amount: int, slot_index: int) -> void:
	"""Update amount of item at the given index, that will be displayed"""
	# If index is correct, update the amount
	if slot_index > -1:
		# Get slot at the given index and update its item amount
		var slot: InventorySlot = item_container.get_child(slot_index)
		slot.amount_label.text = str(amount)
