extends Node2D;

func _on_player_player_weapon_launched(weapon):
	$ProjectileContainer.add_child(weapon);
