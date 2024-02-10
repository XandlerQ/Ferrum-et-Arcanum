extends Entity;
class_name Player;

func movement(delta: float):
	var movementDirectionInput: Vector2 = $PlayerInput.get_movement_direction_input();
	var runningInput: bool = $PlayerInput.get_run_input();
	var dashInput: bool = $PlayerInput.get_dash_input();
	$EntityRotation.rotate_to_target(delta, get_global_mouse_position());
	if (dashInput):
		$EntityMovement.dash_in_direction(delta, movementDirectionInput);
		$EntityHMS.lower_stamina(2);
	elif (runningInput):
		$EntityMovement.run_in_direction(delta, movementDirectionInput);
	else:
		$EntityMovement.walk_in_direction(delta, movementDirectionInput);
	move_and_slide();
	$EntityHMS.regenerate_HMS(delta);

func _physics_process(delta):
	movement(delta);
