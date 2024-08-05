class_name PlayerSprite
extends AnimatedSprite2D


"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func animate(velocity: Vector2):
	# If player's moving, play movement animation, otherwise play idle one
	if velocity != Vector2.ZERO:
		_animate_movement(velocity)
	else:
		_animate_idle()

func _animate_movement(velocity: Vector2):
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
		
func _animate_idle():
	"""Animate player idle state"""
	# Change run into idle animation
	var new_animation = animation.replace("Run", "Idle")
	play(new_animation)
