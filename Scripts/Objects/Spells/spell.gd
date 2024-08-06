class_name Spell
extends Area2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# References to nodes
@onready var collision: CollisionShape2D = $Collision
@onready var sprite: AnimatedSprite2D = $Sprite

# Combat related variables
var direction: Vector2
var speed: float
var damage: int


"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func init(data: SpellData):
	pass
