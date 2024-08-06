class_name InventoryUi
extends CanvasLayer


"""----------------------- SIGNALS -----------------------"""
signal equip_item(index: int, slot_type: String)
signal drop_item(index: int)
signal spell_slot_clicked(index: int)


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Get reference to the container for items
@onready var item_container: GridContainer\
 	= $BackgrounContainer/Background/InventoryContainer/InventoryArea/ItemContainer

@onready var spell_slots: Array[InventorySlot] = [
	$BackgrounContainer/Background/InventoryContainer/InventoryArea/SpellUI/SpellContainer/Plant,
	$BackgrounContainer/Background/InventoryContainer/InventoryArea/SpellUI/SpellContainer/Flame,
	$BackgrounContainer/Background/InventoryContainer/InventoryArea/SpellUI/SpellContainer/Ice
]

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
			
	# Go through each spell slot and initialize it
	for slot in spell_slots.size():
		# Connect the right signal to make clicking the spell slot work
		spell_slots[slot].slot_clicked.connect(on_spell_slot_clicked.bind(slot))

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
		
func clear_slot(index: int):
	"""Clear the slot at the given index"""
	# Create an empty slot
	var empty_slot: InventorySlot = INVENTORY_SLOT_SCENE.instantiate()
	# Toggle off the menu
	toggle()
	
	# Reconnect the signals
	empty_slot.equip_item.connect(func(slot_type: String): \
		equip_item.emit(index, slot_type))
	empty_slot.drop_item.connect(func():\
		drop_item.emit(index))
		
	# Get the old slot that was at this index
	var old_slot = item_container.get_child(index)
	# Remove it, and insert the empty one
	item_container.remove_child(old_slot)
	item_container.add_child(empty_slot)
	# Move it to the old position
	item_container.move_child(empty_slot, index)
	
func on_spell_slot_clicked(index: int):
	"""Handle clicking the slot"""
	# Emit a proper signal
	spell_slot_clicked.emit(index)
	
func set_spell_slot(index: int):
	"""Set the selected spell slot"""
	# Go through each of slots and mark it as selected if needed
	for slot in spell_slots.size():
		spell_slots[index].toggle_button_selected(index == slot)
