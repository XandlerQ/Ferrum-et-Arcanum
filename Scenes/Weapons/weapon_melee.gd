extends Weapon;
class_name WeaponMelee;

@onready var pivot: Node2D = $"..";

func _ready():
	SDTimer.one_shot = true;
	SDTimer.wait_time = lifeTime;
	SDTimer.start();

func _on_sd_timer_timeout():
	pivot.queue_free();

func set_ininital_position():
	position = $WeaponMeleeMovement.pivotRadius * Vector2(cos($WeaponMeleeMovement.trajectoryOriginAngle), sin($WeaponMeleeMovement.trajectoryOriginAngle));
	rotation = $WeaponMeleeMovement.trajectoryOriginAngle + $WeaponMeleeMovement.initialRotationAngle;

func movement(delta: float):
	$WeaponMeleeMovement.move(delta);

func _process(delta):
	movement(delta);
