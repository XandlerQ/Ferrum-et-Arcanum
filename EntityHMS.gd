extends Node2D;
class_name EntityHMS;

@export var health: float = 10;
@export var healthMax: float = 10;
@export var healthMaxModifier: float = 1;
@export var healthRegenRate: float = 0.005;
@export var healthRegenRateModifier: float = 1;

@export var mana: float = 10;
@export var manaMax: float = 10;
@export var manaMaxModifier: float = 1;
@export var manaRegenRate: float = 0.01
@export var manaRegenRateModifier: float = 1;

@export var stamina: float = 10;
@export var staminaMax: float = 10;
@export var staminaMaxModifier: float = 1;
@export var staminaRegenRate: float = 0.3;
@export var staminaRegenRateModifier: float = 1;

func get_max_health() -> float:
	return healthMax * healthMaxModifier;

func get_health_regen_rate() -> float:
	return healthRegenRate * healthRegenRateModifier;

func get_max_mana() -> float:
	return manaMax * manaMaxModifier;

func get_mana_regen_rate() -> float:
	return manaRegenRate * manaRegenRateModifier;

func get_max_stamina() -> float:
	return staminaMax * staminaMaxModifier;

func get_stamina_regen_rate() -> float:
	return staminaRegenRate * staminaRegenRateModifier;

func lower_health(value: float) -> void:
	health -= value;
	if (health < 0): health = 0;

func lower_mana(value: float) -> void:
	mana -= value;
	if (mana < 0): mana = 0;

func lower_stamina(value: float) -> void:
	stamina -= value;
	if (stamina < 0): stamina = 0;

func regenerate_health(delta: float):
	var maxValue: float = get_max_health();
	if (health == maxValue): return;
	health += get_health_regen_rate() * delta;
	if (health > maxValue): health = maxValue;

func regenerate_mana(delta: float):
	var maxValue: float = get_max_mana();
	if (mana == maxValue): return;
	mana += get_mana_regen_rate() * delta;
	if (mana > maxValue): mana = maxValue;

func regenerate_stamina(delta: float):
	var maxValue: float = get_max_stamina();
	if (stamina == maxValue): return;
	stamina += get_stamina_regen_rate() * delta;
	if (stamina > maxValue): stamina = maxValue;

func regenerate_HMS(delta: float):
	regenerate_health(delta);
	regenerate_mana(delta);
	regenerate_stamina(delta);
