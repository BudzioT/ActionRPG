class_name Spells
extends Node


"""----------------------- GLOBAL VARIABLES -----------------------"""
# References to nodes
@onready var player_sprite: PlayerSprite = $"../Sprite"

# Data of each spell
var spell_data: Array[SpellData] = [
	preload("res://Resources/Spells/Flame/flame_data.tres")
]
