class_name PlayerSprite
extends AnimatedSprite2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Direction vectors
const DIRECTION_VECTORS = {
	"Front": Vector2(0, 1),
	"Back": Vector2(0, -1),
	"Left": Vector2(-1, 0),
	"Right": Vector2(1, 0)
}

# Directions associated with animations
const ANIMATION_ATTACK_DIRECTIONS = {
	"Front": "Attack_Front",
	"Back": "Attack_Back",
	"Left": "Attack_Left",
	"Right": "Attack_Right"
}

# Direction of attacks
var attack_direction: String

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func animate(velocity: Vector2) -> void:
	# If player's moving, play movement animation, otherwise play idle one
	if velocity != Vector2.ZERO:
		_animate_movement(velocity)
	else:
		_animate_idle()

func _animate_movement(velocity: Vector2) -> void:
	"""Animate the player"""
	# If player's moving to the left, animate left movement
	if velocity.x < 0:
		play("Run_Left")
	# Movement to the right
	elif velocity.x > 0:
		play("Run_Right")
		
	# Movement up
	elif velocity.y < 0:
		play("Run_Back")
	# Movement down
	elif velocity.y > 0:
		play("Run_Front")
		
func _animate_idle() -> void:
	"""Animate player idle state"""
	# Change run into idle animation
	var new_animation = animation.replace("Run", "Idle")
	play(new_animation)
	
func animate_attack() -> void:
	"""Animate player's attacks"""
	attack_direction = animation.split('_')[1]
	play(ANIMATION_ATTACK_DIRECTIONS[attack_direction])
