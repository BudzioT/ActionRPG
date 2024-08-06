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
func _process(delta: float) -> void:
	"""Process spell changes over frames"""
	# Move the spell
	position += speed * delta * direction


"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func init(data: SpellData):
	"""Initialize the spell"""
	# Set all variables based off the data ones
	name = data.name
	collision = data.collision.shape
	damage = data.damage
	speed = data.speed
	
	# Play the correct animation
	sprite.play(name)
