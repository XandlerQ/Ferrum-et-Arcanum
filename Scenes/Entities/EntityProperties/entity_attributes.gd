extends Node2D;
class_name EntityAttributes;

@export var level: int = 1;

@export var vitality: int = 1;
@export var vitalityModifier: int = 0;
@export var vitalityHealthMultiplier: float = 1.5;

@export var endurance: int = 1;
@export var enduranceModifier: int = 0;
@export var enduranceStaminaMultiplier: float = 1.5;

@export var wisdom: int = 1;
@export var wisdomModifier: int = 0;
@export var wisdomManaMultiplier: float = 1.5;

@export var strength: int = 1;
@export var strengthModifier: int = 0;

@export var dexterity: int = 1;
@export var dexterityModifier: int = 0;

@export var precision: int = 1;
@export var precisionModifier: int = 0;

@export var intelligence: int = 1;
@export var intelligenceModifier: int = 0;

@export var spirit: int = 1;
@export var spiritModifier: int = 0;

@export var arcanum: int = 1;
@export var arcunumModifier: int = 0;

func get_attribute(attribute: String) -> int:
	var attributeValue = self.get(attribute);
	if (attributeValue == null):
		return -1;
	return attributeValue + self.get(attribute + "Modifier");

func set_attribute(attribute: String, value: int) -> bool:
	var attributeValue = self.get(attribute);
	if (attributeValue == null):
		return false;
	self.set(attribute, value);
	return true;

func change_attribute_by(attribute: String, value: int) -> bool:
	var attributeValue = self.get(attribute);
	if (attributeValue == null):
		return false;
	self.set(attribute, attributeValue + value);
	return true;

func set_attribute_modifier(attribute: String, value: int) -> bool:
	var attributeModifierValue = self.get(attribute + "Modifier");
	if (attributeModifierValue == null):
		return false;
	self.set(attribute + "Modifier", value);
	return true;

func change_attribute_modifier_by(attribute: String, value: int) -> bool:
	var attributeModifierValue = self.get(attribute + "Modifier");
	if (attributeModifierValue == null):
		return false;
	self.set(attribute + "Modifier", attributeModifierValue + value);
	return true;

func get_attribute_health() -> float:
	return get_attribute("vitality") * vitalityHealthMultiplier;

func get_attribute_stamina() -> float:
	return get_attribute("endurance") * enduranceStaminaMultiplier;

func get_attribute_mana() -> float:
	return get_attribute("wisdom") * wisdomManaMultiplier;



