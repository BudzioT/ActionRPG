class_name PickUpItem
extends Area2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Variables related to the overworld
@export_category("Overworld")
@export var inventory_item: InventoryItem

@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Prepare the item that can be picked up"""
	# Set the correct texture and collisions
	sprite.texture = inventory_item.texture
	collision.shape = inventory_item.collision_shape
