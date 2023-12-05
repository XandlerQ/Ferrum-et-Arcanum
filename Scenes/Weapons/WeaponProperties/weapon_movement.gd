extends Node2D;
class_name WeaponMovement;

@onready var weapon: Weapon = $"..";
@export var trajectoryType: String = "Linear";
var trajectoryRelativeOrigin: Vector2 = Vector2(7, 15);
var direction: Vector2 = Vector2.RIGHT;
@export var speed: float = 300.;
var timeSinceLaunch: float = 0;

func update_time_since_launch(delta: float):
	timeSinceLaunch += delta;

func get_relative_coordinates_along_trajectory(delta: float) -> Vector2:
	update_time_since_launch(delta);
	var coordinates: Vector2 = trajectoryRelativeOrigin + timeSinceLaunch * speed * direction;
	return coordinates;

func move_along_trajectory(delta: float):
	update_time_since_launch(delta);
	weapon.global_position += delta * speed * direction;

func get_orientation_along_trajectory() -> float:
	return direction.angle();

func orient_along_trajectory():
	weapon.rotation = get_orientation_along_trajectory();
