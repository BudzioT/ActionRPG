class_name Combat
extends Node2D


"""----------------------- GLOBAL VARIABLES -----------------------"""
# References to nodes
@onready var player_sprite: PlayerSprite = $"../Sprite"

# Left weapon references
@onready var left_weapon_sprite: Sprite2D = $LeftWeaponSprite
@onready var left_weapon_collision: CollisionShape2D = $LeftWeaponSprite/AttackArea/Collision
# Right weapon references
@onready var right_weapon_sprite: Sprite2D = $RightWeaponSprite
@onready var right_weapon_collision: CollisionShape2D = $RightWeaponSprite/AttackArea/Collision

# Item related variables
@export_category("Item")
@export var left_weapon: WeaponItem
@export var right_weapon: WeaponItem

# Player attack ability flag
var allow_attack = true


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Initialize the combat system"""
	# Connect the right function to end attack animation
	player_sprite.attack_animation_finished.connect(_attack_animation_finished)

func _input(_event: InputEvent) -> void:
	"""Handle combat-related input"""
	# If player is able to attack, try to do this
	if allow_attack:
		# Handle attack using left weapon
		if Input.is_action_just_pressed("Left_Hand_Use"):
			# Make player not able to attack
			allow_attack = false
			
			# Animate the attack
			player_sprite.animate_attack()
			
			# If there is currently a weapon equipped, set its data
			if left_weapon:
				# Set attack direction
				var attack_direction = player_sprite.attack_direction
				
				# Get data of the right weapon
				var weapon_data = left_weapon.get_direction_data(attack_direction)
				# Set the weapon attributes
				left_weapon_sprite.position = weapon_data.get("Attachment")
				left_weapon_sprite.rotation_degrees = weapon_data.get("Rotation")
				left_weapon_sprite.z_index = weapon_data.get("Depth")
				
				# Use a side texture if needed
				if left_weapon.side_texture and ["Back", "Left", "Right"].has(attack_direction):
					left_weapon_sprite.texture = left_weapon.side_texture
				else:
					left_weapon_sprite.texture = left_weapon.texture
				
				# Show the weapon
				left_weapon_sprite.show()
			
		elif Input.is_action_just_pressed("Right_Hand_Use"):
			# Disallow attacks
			allow_attack = false
			
			# Play the attack animation
			player_sprite.animate_attack()
			
			# If right weapon exists, attack
			if right_weapon:
				# Get attack direction
				var attack_direction = player_sprite.attack_direction
				
				# If this weapon has a side texture, use it in the proper place
				if right_weapon.side_texture and ["Back", "Left", "Right"].has(attack_direction):
					right_weapon_sprite.texture = right_weapon.side_texture
				else:
					right_weapon_sprite.texture = right_weapon.texture
				
				# Get weapon's data
				var weapon_data = right_weapon.get_direction_data(attack_direction)
				# Set the data
				right_weapon_sprite.position = weapon_data.get("Attachment")
				right_weapon_sprite.rotation_degrees = weapon_data.get("Rotation")
				right_weapon_sprite.z_index = weapon_data.get("Depth")
				
				# Show it
				right_weapon_sprite.show()
	
	
"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func set_weapon(weapon: WeaponItem, slot_type: String):
	"""Set currently used weapon"""
	# Handle left weapon slot
	if slot_type == "Left_Weapon":
		# If there is a weapon collision shape, set it
		if weapon.collision:
			left_weapon_collision.shape = weapon.collision
		
		# Set the correct sprite, and save this weapon as current left weapon
		left_weapon_sprite.texture = weapon.texture
		left_weapon = weapon
		
	# Otherwise try to equipt it as the right weapon
	elif slot_type == "Right_Weapon":
		# If collision shape exists, set it
		if weapon.collision:
			right_weapon_collision.shape = weapon.collision
			
		# Set this weapon as the right one, and set its sprite
		right_weapon_sprite.texture = weapon.texture
		right_weapon = weapon
		
func _attack_animation_finished():
	"""Handle finishing attack animation"""
	# Allow attacking again
	allow_attack = true
	
	# Hide the weapons when animation is finished
	right_weapon_sprite.hide()
	left_weapon_sprite.hide()
