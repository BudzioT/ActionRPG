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
var allow_attack = false


"""----------------------- BUILT-IN FUNCTIONS -----------------------"""
func _ready() -> void:
	"""Initialize the combat system"""
	# Connect the right function to end attack animation
	player_sprite.attack_animation_finished.connect(_attack_animation_finished)

func _input(_event: InputEvent) -> void:
	"""Handle combat-related input"""
	# If player is able to attack, try to do this
	if allow_attack:
		# Make player not able to attack
		allow_attack = false
		
		# Handle attack using left weapon
		if Input.is_action_just_pressed("Left_Hand_Use"):
			player_sprite.animate_attack()
			
		elif Input.is_action_just_pressed("Right_Hand_Use"):
			player_sprite.animate_attack()
	
	
"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func set_weapon(weapon: WeaponItem, slot_type: String):
	"""Set currently used weapon"""
	# Handle left weapon slot
	if slot_type == "Left_Weapon":
		# If there is a weapon collision shape, set it
		if weapon.collision:
			left_weapon_collision.shape = weapon.collision
		
		# Set the correct sprite, and save this weapon as current left weapon
		left_weapon_sprite.texture = weapon.side_texture
		left_weapon = weapon
		
	# Otherwise try to equipt it as the right weapon
	elif slot_type == "Right_Weapon":
		# If collision shape exists, set it
		if weapon.collision:
			right_weapon_collision.shape = weapon.collision
			
		# Set this weapon as the right one, and set its sprite
		right_weapon_sprite.texture = weapon.side_texture
		right_weapon = weapon
		
func _attack_animation_finished():
	"""Handle finishing attack animation"""
	# Allow attacking again
	allow_attack = true
