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

@onready var menu_button: MenuButton = $Background/Menu
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
		
	# Handle user opening and closing the menu
	menu_button.disabled = single_click
	button.disabled = !single_click
	button.visible = single_click
	
	# Get the popup menu
	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(_popup_menu_item_pressed)
	

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func _popup_menu_item_pressed(id: int) -> void:
	"""Handle player pressing the menu"""
	print_debug(id)
	
func add_item(item: InventoryItem):
	"""Add an item to the slot"""
	# If item is equipable
	if item.placement != "Normal":
		# Get the popup menu
		var popup_menu: PopupMenu = menu_button.get_popup()
		
		# Get the placement name, and split it with a space for style
		var slot_name_array = item.placement.to_lower().split('_')
		var slot_placement_name = " ".join(slot_name_array)
		
		# Set the popup menu equip text
		popup_menu.set_item_text(0, "Equip as " + slot_placement_name)
		
	# Set the slot as occupied, disable menu button
	empty = false
	menu_button.disabled = false
	# Set correct icon and name
	icon.texture = item.texture
	name_label.text = item.name
	
	# If there is more than one time, show the amount of it
	if item.amount > 1:
		amount_label.text = str(item.amount)
	
