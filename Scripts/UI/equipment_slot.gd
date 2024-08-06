class_name EquipmentSlot
extends VBoxContainer

"""----------------------- GLOBAL VARIABLES -----------------------"""
# Get quick acces to nodes
@onready var label: Label = $EquipLabel
@onready var icon: TextureRect = $Background/SlotContainer/Icon

# Style variables
@export_category("Style")
@export var slot_name: String


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the equipment slot"""
	# Set the proper name
	label.text = slot_name
	
func set_texture(texture: Texture):
	"""Set texture of the icon to the given one"""
	icon.texture = texture
