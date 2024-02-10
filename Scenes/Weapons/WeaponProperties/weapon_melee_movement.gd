extends Node2D;
class_name WeaponMeleeMovement;

#region Variables

# Melee weapon
@onready var weapon: WeaponMelee = $"..";
# Trajectory origin relative to weilder
@export var trajectoryOriginAngle: float = PI / 2;

# Pivot radius
@export var pivotRadius: float = 15;
# Pivot speed
@export var pivotSpeed: float = -1.5;

# Initial self rotation angle
@export var initialRotationAngle: float = 0;
# Projectile self rotation speed (radians / time)
@export var rotationSpeed: float = 0;

# Time since projectile launch
var timeSinceLaunch: float = 0;
#endregion

#region Kinematic properties functions
func pivot_radius_function(_t: float) -> float:
	var constPivotRadius = 15;
	return constPivotRadius;

func pivot_speed_function(_t: float) -> float:
	var constPivotSpeed = -1.5;
	return constPivotSpeed;

func rotation_speed_function(_t: float) -> float:
	var constRotationSpeed = 0;
	return constRotationSpeed;
#endregion

# Updates all kinematic properties according to functions
func update_kinematic_properties():
	pivotRadius = pivot_radius_function(timeSinceLaunch);
	pivotSpeed = pivot_speed_function(timeSinceLaunch);
	rotationSpeed = rotation_speed_function(timeSinceLaunch);

# Increments time since launch variable
func update_time_since_launch(delta: float):
	timeSinceLaunch += delta;

# Orients weapon along trjectory taking rotation speed into account
func rotation_speed_orient(delta: float):
	weapon.rotation = weapon.rotation + delta * rotationSpeed;

# Updates projectile position
func move(delta: float):
	# Increment time since launch
	update_time_since_launch(delta);
	# Recalculate kinematic properties
	update_kinematic_properties();
	# Update distance to pivot
	weapon.position = pivotRadius * Vector2(cos(trajectoryOriginAngle), sin(trajectoryOriginAngle));
	# Rotate pivot
	weapon.pivot.rotation += delta * pivotSpeed;
	
	if (rotationSpeed != 0):
		rotation_speed_orient(delta);
