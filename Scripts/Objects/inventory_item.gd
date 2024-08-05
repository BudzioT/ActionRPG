class_name InventoryItem
extends Resource

"""----------------------- GLOBAL VARIABLES -----------------------"""
# Current amount of this item
var amount = 1

# Usage related variables
@export_category("Usage")
@export_enum("Right_Weapon", "Left_Weapon", "Potion", "Normal")
var placement: String = "Normal"
@export var max_amount: int
@export var price: int

# Style variables
@export_category("Style")
@export var collision_shape: ConvexPolygonShape2D
@export var texture: Texture2D
@export var side_texture: Texture2D
