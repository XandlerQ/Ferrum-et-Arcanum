extends Node2D;
class_name PlayerInput;

func get_movement_direction_input() -> Vector2:
	return Input.get_vector("Left", "Right", "Up", "Down");

func get_run_input() -> bool:
	return Input.is_action_pressed("Run");

func get_dash_input() -> bool:
	return Input.is_action_just_pressed("Dash");

func get_attack_input() -> bool:
	return Input.is_action_just_pressed("Attack");
