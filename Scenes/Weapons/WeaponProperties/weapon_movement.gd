extends Node2D;
class_name WeaponMovement;

@onready var weapon: Weapon = $"..";
var trajectoryOrigin: Vector2;
var trajectoryRelativeOrigin: Vector2 = Vector2(0, 25);
var direction: Vector2 = Vector2.RIGHT;

@export var initialSpeed: float = 200;
@export var finalSpeed: float = 0;
@export var acceleration: float = -2;
var speed: float = initialSpeed;

@export var swerveAmplitude: float = 10;
@export var initialSwerveSpeed: float = 10;
@export var finalSwerveSpeed: float = 0;
@export var swerveAcceleration: float = -2;
var swerveSpeed: float = initialSwerveSpeed;

@export var loopingRadius: float = 0;
@export var initialLoopingSpeed: float = -5;
@export var finalLoopingSpeed: float = -30;
@export var loopingAcceleration: float = -50;
var loopingSpeed: float = initialLoopingSpeed;

@export var initialRotationSpeed: float = 0;
@export var finalRotationSpeed: float = 0;
@export var rotationAcceleration: float = -15;
var rotationSpeed: float = initialRotationSpeed;

var timeSinceLaunch: float = 0;

func update_speed(delta: float):
	if (acceleration == 0): return;
	speed += delta * acceleration;
	if (initialSpeed < finalSpeed):
		if (speed > finalSpeed):
			speed = finalSpeed;
	else:
		if (speed < finalSpeed):
			speed = finalSpeed;

func update_swerve_speed(delta: float):
	if (swerveAcceleration == 0): return;
	swerveSpeed += delta * swerveAcceleration;
	if (initialSwerveSpeed < finalSwerveSpeed):
		if (swerveSpeed > finalSwerveSpeed):
			swerveSpeed = finalSwerveSpeed;
	else:
		if (swerveSpeed < finalSwerveSpeed):
			swerveSpeed = finalSwerveSpeed;

func update_looping_speed(delta: float):
	if (loopingAcceleration == 0): return;
	loopingSpeed += delta * loopingAcceleration;
	if (initialLoopingSpeed < finalLoopingSpeed):
		if (loopingSpeed > finalLoopingSpeed):
			loopingSpeed = finalLoopingSpeed;
	else:
		if (loopingSpeed < finalLoopingSpeed):
			loopingSpeed = finalLoopingSpeed;

func update_rotation_speed(delta: float):
	if (rotationAcceleration == 0): return;
	rotationSpeed += delta * rotationAcceleration;
	if (finalRotationSpeed < finalRotationSpeed):
		if (rotationSpeed > finalRotationSpeed):
			rotationSpeed = finalRotationSpeed;
	else:
		if (rotationSpeed < finalRotationSpeed):
			rotationSpeed = finalRotationSpeed;

func update_speeds(delta: float):
	update_speed(delta);
	update_swerve_speed(delta);
	update_looping_speed(delta);
	update_rotation_speed(delta);

func update_time_since_launch(delta: float):
	timeSinceLaunch += delta;

func get_relative_coordinates_along_trajectory(delta: float) -> Vector2:
	var coordinates: Vector2 = Vector2(0, 0);
	if (speed != 0):
		coordinates += delta * speed * direction;
	var normalVector: Vector2 = direction.rotated(PI / 2);
	if (swerveAmplitude != 0):
		coordinates += delta * swerveAmplitude * normalVector * swerveSpeed * cos(swerveSpeed * timeSinceLaunch);
	if (loopingRadius != 0):
		var trajectoryRelativeOriginAngle: float = trajectoryRelativeOrigin.rotated(direction.angle()).angle();
		var loopingVector: Vector2 = Vector2(
			-sin(loopingSpeed * timeSinceLaunch + trajectoryRelativeOriginAngle), 
			cos(loopingSpeed * timeSinceLaunch + trajectoryRelativeOriginAngle)
			);
		coordinates += delta * loopingSpeed * loopingRadius * loopingVector;
	
	return coordinates;

func move_along_trajectory(delta: float):
	weapon.global_position += get_relative_coordinates_along_trajectory(delta);

func get_orientation_along_trajectory(delta: float) -> float:
	return $"..".rotation + delta * rotationSpeed;

func orient_along_trajectory(delta: float):
	weapon.rotation = get_orientation_along_trajectory(delta);
