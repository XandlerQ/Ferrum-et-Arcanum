extends Area2D;
class_name Weapon;

func movement(delta: float):
	$WeaponMovement.move_along_trajectory(delta);

func _process(delta):
	movement(delta);
