extends CharacterBody2D;

func get_movement_direction_input() -> Vector2:
	return Input.get_vector("Left", "Right", "Up", "Down");

func movement(delta: float):
	var movementDirectionInput: Vector2 = get_movement_direction_input();
	var runningInput: bool = Input.is_action_pressed("Run");
	if (runningInput):
		$EntityMovement.run_in_direction(delta, movementDirectionInput);
	else:
		$EntityMovement.walk_in_direction(delta, movementDirectionInput);

func _physics_process(delta):
	movement(delta);
