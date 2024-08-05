class_name WeaponItem
extends Resource

"""----------------------- GLOBAL VARIABLES -----------------------"""
# Attack related variables
@export_category("Attack")
@export var collision: RectangleShape2D
@export_enum("Melee", "Magic", "Ranged") var attack_type: String

# Style variables
@export_category("Style")
@export var texture: Texture
@export var side_texture: Texture

# Attachment positions
@export_category("Attachment")
@export var left_attachment: Vector2
@export var right_attachment: Vector2
@export var front_attachment: Vector2
@export var back_attachment: Vector2

# Depth positions
@export_category("Depth")
@export var left_depth_index: int
@export var right_depth_index: int
@export var front_depth_index: int
@export var back_depth_index: int

# Rotations
@export_category("Rotation")
@export var left_rotation: int
@export var right_rotation: int
@export var front_rotation: int
@export var back_rotation: int


"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func get_direction_data(direction: String):
	"""Get data associated with the weapon's direction"""
	# Return proper data depending on the direction
	match direction:
		"Left":
			return {
				"Attachment": left_attachment,
				"Rotation": left_rotation,
				
			}
