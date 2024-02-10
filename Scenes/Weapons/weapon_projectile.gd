extends Weapon;
class_name WeaponProjectile;

func _ready():
	set_as_top_level(true);
	SDTimer.one_shot = true;
	SDTimer.wait_time = lifeTime;
	SDTimer.start();

func _on_sd_timer_timeout():
	queue_free();

func set_ininital_position(wielderGlobalPosition: Vector2, wielderOrientation: float, targetGlobalPosition: Vector2):
	var initialGlobalPosition: Vector2 = wielderGlobalPosition + $WeaponProjectileMovement.trajectoryRelativeOrigin.rotated(wielderOrientation);
	global_position = initialGlobalPosition
	var targetInitialPositionDifference: Vector2 = targetGlobalPosition - initialGlobalPosition;
	var targetDistance: float = targetInitialPositionDifference.length();
	var direction: Vector2 = ((targetDistance / 90) * targetInitialPositionDifference + (targetGlobalPosition - wielderGlobalPosition)).normalized();
	$WeaponProjectileMovement.launchDirection = direction;
	rotation = direction.angle();

func movement(delta: float):
	$WeaponProjectileMovement.move(delta);

func _process(delta):
	movement(delta);
