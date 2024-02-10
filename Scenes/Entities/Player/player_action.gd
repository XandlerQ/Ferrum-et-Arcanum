extends Node2D;
class_name PlayerAction;

var weaponProjectileScene: PackedScene = preload("res://Scenes/Weapons/weapon_projectile.tscn");
var weaponMeleeScene: PackedScene = preload("res://Scenes/Weapons/weapon_melee.tscn");
var weaponMeleePivot: PackedScene = preload("res://Scenes/Weapons/WeaponProperties/weapon_melee_pivot.tscn");

func _process(_delta):
	var attackInput: bool = $"../PlayerInput".get_attack_input();
	if (attackInput):
		#var weapon = weaponProjectileScene.instantiate() as WeaponProjectile;
		var weapon = weaponMeleeScene.instantiate() as WeaponMelee;
		var pivot = weaponMeleePivot.instantiate() as Node2D;
		#weapon.set_ininital_position($"../EntityMovement".entityGlobalPosition, $"../EntityRotation".entityRotation, get_global_mouse_position());
		weapon.set_ininital_position();
		pivot.add_child(weapon);
		#$"../ProjectileContainer".add_child(weapon);
		$"../ProjectileContainer".add_child(pivot);

