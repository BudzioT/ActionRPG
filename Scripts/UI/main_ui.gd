class_name MainUi
extends CanvasLayer


"""----------------------- GLOBAL VARIABLES -----------------------"""
# Node references
@onready var right_hand_slot: EquipmentSlot = $MainUIContainer/SlotContainer/RightHand
@onready var left_hand_slot: EquipmentSlot = $MainUIContainer/SlotContainer/LeftHand
@onready var spell_slot: EquipmentSlot = $MainUIContainer/SlotContainer/Spell
@onready var potion_slot: EquipmentSlot = $MainUIContainer/SlotContainer/Potion

# Dictionary of item types associated with slots
@onready var slots_dictionary = {
	"Right_Weapon": right_hand_slot,
	"Left_Weapon": left_hand_slot,
	"Potion": potion_slot
}


"""----------------------- USER-DEFINED FUNCTIONS -----------------------"""
func equip_item(item: InventoryItem, slot_type: String):
	"""Equip given item to the proper slot type"""
	if item:
		slots_dictionary[slot_type].set_texture(item.texture)
