class_name PickUpItem
extends Area2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Variables related to the overworld
@export_category("Overworld")
@export var inventory_item: InventoryItem
@export var amount: int = 1

@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the item that can be picked up"""
	# Set the correct texture and collisions
	sprite.texture = inventory_item.texture
	collision.shape = inventory_item.collision_shape
	

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func disable_collisions():
	"""Disable item collisions"""
	collision.disabled = true
	
func enable_collisions():
	"""Enable item collisions"""
	collision.disabled = false
