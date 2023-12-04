extends Entity;

func get_movement_direction_input() -> Vector2:
	return Input.get_vector("Left", "Right", "Up", "Down");

func movement(delta: float):
	var movementDirectionInput: Vector2 = get_movement_direction_input();
	var runningInput: bool = Input.is_action_pressed("Run");
	var dashInput: bool = Input.is_action_just_pressed("Dash");
	$EntityRotation.rotate_to_target(delta, get_global_mouse_position());
	if (runningInput):
		$EntityMovement.run_in_direction(delta, movementDirectionInput);
	elif (dashInput):
		$EntityMovement.dash_in_direction(delta, movementDirectionInput);
		$EntityHMS.lower_stamina(2);
	else:
		$EntityMovement.walk_in_direction(delta, movementDirectionInput);
	
	$EntityHMS.regenerate_HMS(delta);

func _physics_process(delta):
	movement(delta);
