extends Node2D;
class_name WeaponMovement;

@onready var weapon: Weapon = $"..";

@export var trajectoryType: String = "Linear";
var trajectoryOrigin: Vector2;
@export var direction: Vector2 = Vector2.RIGHT;
@export var speed: float = 10.;
var timeSinceLaunch: float = 0;

func updateTimeSinceLaunch(delta: float):
	timeSinceLaunch += delta;

func get_coordinates_along_trajectory(delta: float) -> Vector2:
	updateTimeSinceLaunch(delta);
	var coordinates: Vector2 = trajectoryOrigin + timeSinceLaunch * speed * direction;
	return coordinates;

func move_along_trajectory(delta: float):
	updateTimeSinceLaunch(delta);
	weapon.global_position += delta * speed * direction;
