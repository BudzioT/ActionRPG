extends CharacterBody2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Movement variables
@export_category("Movement")
@export var speed: float = 100.0
@export var deceleration: float = 300.0

@onready var sprite: PlayerSprite = $Sprite


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _physics_process(delta: float) -> void:
	"""Process physics changes"""
	# Get the direction
	var direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()
	
	# If there is movement, update the velocity
	if direction.length() > 0:
		velocity = direction * speed
	# Otherwise deccelerate slowly
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	# Animate the player
	$Sprite.animate(velocity)
		
	# Move with current velocity
	move_and_slide()
