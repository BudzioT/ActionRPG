class_name InventorySlot
extends VBoxContainer



"""----------------------- GLOBAL VARIABLES -----------------------"""
# Inventory flags
var empty: bool = true
var selected: bool = false

# State variables
@export_category("State")
@export var single_click: bool = false

# Style related variables
@export_category("Style")
@export var texture: Texture
@export var label: String

# Get all the nodes as variables, for easy access
@onready var icon: TextureRect = $Background/Menu/MenuContainer/Icon
@onready var name_label: Label = $NameLabel
@onready var amount_label: Label = $Background/AmountLabel
@onready var price_label: Label = $PriceLabel

@onready var button: Button = $Background/Button

# Place to put the item in
var slot_type = "Normal"


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Initialize the inventory slot"""
	# Set the icon if it exists
	if texture != null:
		icon.texture = texture
		
	# If label exists, set it
	if label != null:
		name_label.text = label
		
	# If user pressed a single time, hide the clickable area
	button.disabled = single_click
	
