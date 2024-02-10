extends Node2D;
class_name WeaponProjectileMovement;

#region Variables

# Projectile weapon
@onready var weapon: WeaponProjectile = $"..";
# Trajectory origin relative to thrower
var trajectoryRelativeOrigin: Vector2 = Vector2(0, 25);

# Direction of launch
var launchDirection: Vector2 = Vector2.RIGHT;
# Current direction of movement
var direction: Vector2 = Vector2.ZERO;


# Projectile speed
var speed: float = 0;

# Projectile swerve speed (radians / time)
var swerveSpeed: float = 0;
# Projectile swerve amplitude
var swerveAmplitude: float = 0;

# Stable projectile flag
# If true, projectile is oriented along it's movement path
@export var stable: bool = true;
# Projectile self rotation speed (radians / time)
var rotationSpeed: float = 0;

# Time since projectile launch
var timeSinceLaunch: float = 0;
#endregion

#region Kinematic properties functions
func speed_function(_t: float) -> float:
	var constSpeed = 300;
	return constSpeed;

func swerve_speed_function(_t: float) -> float:
	var constSwerveSpeed = 0;
	return constSwerveSpeed;

func swerve_amplitude_function(_t: float) -> float:
	var constSwerveAmplitude = 0;
	return constSwerveAmplitude;

func rotation_speed_function(_t: float) -> float:
	var constRotationSpeed = 0;
	return constRotationSpeed;
#endregion

# Updates all kinematic properties according to functions
func update_kinematic_properties():
	speed = speed_function(timeSinceLaunch);
	swerveSpeed = swerve_speed_function(timeSinceLaunch);
	swerveAmplitude = swerve_amplitude_function(timeSinceLaunch);
	rotationSpeed = rotation_speed_function(timeSinceLaunch);

# Increments time since launch variable
func update_time_since_launch(delta: float):
	timeSinceLaunch += delta;

# Returns increment of coordinates relative to current projectile position
func get_relative_coordinates_along_trajectory(delta: float) -> Vector2:
	var coordinates: Vector2 = Vector2(0, 0);
	if (speed != 0):
		coordinates += delta * speed * launchDirection;
	var normalVector: Vector2 = launchDirection.rotated(PI / 2);
	if (swerveAmplitude != 0):
		coordinates += delta * swerveAmplitude * normalVector * swerveSpeed * cos(swerveSpeed * timeSinceLaunch);
	
	return coordinates;

# Orients weapon along trjectory taking rotation speed into account
func rotation_speed_orient(delta: float):
	weapon.rotation = weapon.rotation + delta * rotationSpeed;

func orient_along_direction(dir: Vector2):
	weapon.rotation = dir.angle();

# Updates projectile position
func move(delta: float):
	# Increment time since launch
	update_time_since_launch(delta);
	# Recalculate kinematic properties
	update_kinematic_properties();
	# Get coordinate increment
	var relativeCoordinates: Vector2 = get_relative_coordinates_along_trajectory(delta);
	# Calculate direction of movement
	direction = relativeCoordinates.normalized();
	# Update weapon global position
	weapon.global_position += get_relative_coordinates_along_trajectory(delta);
	
	# If projectile is stable
	if (stable):
		# Orient along direction of movement
		orient_along_direction(direction);
	else:
		# Else orient according to rotation speed
		rotation_speed_orient(delta);


