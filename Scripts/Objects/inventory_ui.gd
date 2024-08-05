class_name InventoryUi
extends CanvasLayer



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

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func toggle() -> void:
	"""Toggle the inventory UI"""
	visible = !visible
