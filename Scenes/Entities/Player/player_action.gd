extends Node2D;
class_name PlayerAction;

signal weapon_launched(weapon: Weapon);

var weapon_scene: PackedScene = preload("res://Scenes/Weapons/weapon.tscn");

func _process(delta):
	var attackInput: bool = $"../PlayerInput".get_attack_input();
	if (attackInput):
		var weapon = weapon_scene.instantiate() as Weapon;
		weapon.set_ininital_position($"../EntityMovement".entityGlobalPosition, $"../EntityRotation".entityRotation, get_global_mouse_position());
		weapon_launched.emit(weapon);

