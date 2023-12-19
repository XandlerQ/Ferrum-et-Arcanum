extends Area2D;
class_name Weapon;

@export var lifeTime: float = 2;
@onready var SDTimer: Timer = $SDTimer;

func _ready():
	SDTimer.one_shot = true;
	SDTimer.wait_time = lifeTime;
	SDTimer.start();

func set_ininital_position(wielderGlobalPosition: Vector2, wielderOrientation: float, targetGlobalPosition: Vector2):
	var initialGlobalPosition: Vector2 = wielderGlobalPosition + $WeaponMovement.trajectoryRelativeOrigin.rotated(wielderOrientation);
	$WeaponMovement.trajectoryOrigin = initialGlobalPosition;
	global_position = initialGlobalPosition
	var targetInitialPositionDifference: Vector2 = targetGlobalPosition - initialGlobalPosition;
	var targetDistance: float = targetInitialPositionDifference.length();
	var direction: Vector2 = ((targetDistance / 90) * targetInitialPositionDifference + (targetGlobalPosition - wielderGlobalPosition)).normalized();
	$WeaponMovement.direction = direction;
	rotation = direction.angle();

func movement(delta: float):
	$WeaponMovement.update_time_since_launch(delta);
	$WeaponMovement.update_speeds(delta);
	$WeaponMovement.move_along_trajectory(delta);
	$WeaponMovement.orient_along_trajectory(delta);

func _process(delta):
	movement(delta);


func _on_sd_timer_timeout():
	queue_free();
