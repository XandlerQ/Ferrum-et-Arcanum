extends Area2D;
class_name Weapon;

@export var lifeTime: float = 10.;
@onready var SDTimer: Timer = $SDTimer;

func _ready():
	SDTimer.one_shot = true;
	SDTimer.wait_time = lifeTime;
	SDTimer.start();

func set_ininital_position(wielderGlobalPosition: Vector2, wielderOrientation: float, targetGlobalPosition: Vector2):
	var initialGlobalPosition: Vector2 = wielderGlobalPosition + $WeaponMovement.trajectoryRelativeOrigin.rotated(wielderOrientation);
	global_position = initialGlobalPosition
	var targetInitialPositionDifference: Vector2 = targetGlobalPosition - initialGlobalPosition;
	if (targetInitialPositionDifference.length() > 3 * $WeaponMovement.trajectoryRelativeOrigin.length()):
		$WeaponMovement.direction = (targetGlobalPosition - initialGlobalPosition).normalized();
	else:
		$WeaponMovement.direction = (targetGlobalPosition - wielderGlobalPosition).normalized();
	rotation = $WeaponMovement.get_orientation_along_trajectory();

func movement(delta: float):
	$WeaponMovement.move_along_trajectory(delta);
	$WeaponMovement.orient_along_trajectory();

func _process(delta):
	movement(delta);


func _on_sd_timer_timeout():
	queue_free();
