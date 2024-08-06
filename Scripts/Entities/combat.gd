class_name Combat
extends Node2D

"""----------------------- GLOBAL VARIABLES -----------------------"""
# Reference to the player sprite
@onready var player_sprite: PlayerSprite = $"../Sprite"


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _input(event: InputEvent) -> void:
	"""Handle combat-related input"""
	# Handle attack using left weapon
	if Input.is_action_just_pressed("Left_Hand_Use"):
		player_sprite.animate_attack()
	elif Input.is_action_just_pressed("Right_Hand_Use"):
		player_sprite.animate_attack()
		
