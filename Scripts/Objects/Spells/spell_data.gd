class_name Spells
extends Resource


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Style variables
@export_category("Style")
@export var name: String
@export var ui_texture: Texture
@export var start_rotation: int = 0

# Combat related variables
@export_category("Combat")
@export var collision: RectangleShape2D
@export var speed: float = 10
@export var start_cooldown: float
@export var damage: int = 10
