extends Node2D;
class_name WeaponMovement;

@onready var weapon: Weapon = $"..";
@export var trajectoryType: String = "Linear";
var trajectoryRelativeOrigin: Vector2 = Vector2(7, 15);
var direction: Vector2 = Vector2.RIGHT;
@export var 
@export var initialSpeed: float = 100;
@export var finalSpeed: float = 300;
@export var acceleration: float = 20;
var speed: float = initialSpeed;
@export var rotationSpeed: float = 20;
var timeSinceLaunch: float = 0;

func update_speed(delta: float):
	speed += delta * acceleration;
	if (initialSpeed < finalSpeed)

func update_time_since_launch(delta: float):
	timeSinceLaunch += delta;

func get_relative_coordinates_along_trajectory(delta: float) -> Vector2:
	var coordinates: Vector2 = trajectoryRelativeOrigin + timeSinceLaunch * speed * direction;
	return coordinates;

func move_along_trajectory(delta: float):
	weapon.global_position += delta * speed * direction;

func get_orientation_along_trajectory(delta: float) -> float:
	return $"..".rotation + delta * rotationSpeed;

func orient_along_trajectory(delta: float):
	weapon.rotation = get_orientation_along_trajectory(delta);
