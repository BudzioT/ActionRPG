class_name PlayerSprite
extends AnimatedSprite2D


"""----------------------- SIGNALS -----------------------"""
signal attack_animation_finished


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
var attack_direction = null
# Direction of item after dropping it
var drop_direction = Vector2.DOWN

"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func animate(velocity: Vector2) -> void:
	# If player isn't currently attacking, animate him
	if not ANIMATION_ATTACK_DIRECTIONS.values().has(animation):
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
		# Set the proper item drop direction
		drop_direction = Vector2.LEFT
	# Movement to the right
	elif velocity.x > 0:
		play("Run_Right")
		drop_direction = Vector2.RIGHT
		
	# Movement up
	elif velocity.y < 0:
		play("Run_Back")
		drop_direction = Vector2.UP
	# Movement down
	elif velocity.y > 0:
		play("Run_Front")
		drop_direction = Vector2.DOWN
		
func _animate_idle() -> void:
	"""Animate player idle state"""
	# Change run into idle animation
	var new_animation = animation.replace("Run", "Idle")
	play(new_animation)
	
func animate_attack() -> void:
	"""Animate player's attacks"""
	attack_direction = animation.split('_')[1]
	play(ANIMATION_ATTACK_DIRECTIONS[attack_direction])


func _animation_finished() -> void:
	"""Set the correct animation, after finishing current one"""
	# If attack has finished, go back to idle
	if ANIMATION_ATTACK_DIRECTIONS.values().has(animation):
		# Get the animation name and its direction
		var animation_name: String = String(animation)
		var direction = ANIMATION_ATTACK_DIRECTIONS.find_key(animation_name)
		
		# Play the idle animation
		play("Idle_" + direction)
		attack_direction = null
		
		# Emit signal, that the attack animation is finished
		attack_animation_finished.emit()
