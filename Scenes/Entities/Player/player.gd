extends Entity;
class_name Player;

signal player_weapon_launched(weapon: Weapon);

func movement(delta: float):
	var movementDirectionInput: Vector2 = $PlayerInput.get_movement_direction_input();
	var runningInput: bool = $PlayerInput.get_run_input();
	var dashInput: bool = $PlayerInput.get_dash_input();
	$EntityRotation.rotate_to_target(delta, get_global_mouse_position());
	if (runningInput):
		$EntityMovement.run_in_direction(delta, movementDirectionInput);
	elif (dashInput):
		$EntityMovement.dash_in_direction(delta, movementDirectionInput);
		$EntityHMS.lower_stamina(2);
	else:
		$EntityMovement.walk_in_direction(delta, movementDirectionInput);
	
	$EntityHMS.regenerate_HMS(delta);

func _process(delta):
	movement(delta);


func _on_player_action_weapon_launched(weapon):
	player_weapon_launched.emit(weapon);
