extends Node2D;
class_name EntityRotation;

# --- Entity ---
@onready var entity: CharacterBody2D = $"..";

# --- Entity properties ---
var entityGlobalPosition: Vector2 = Vector2.ZERO;
var entityRotation: float = 0;

@export var baseRotationSpeed: float = 1;
@export var additionalRotationSpeed: float = 30;

func update_entity_properties() -> void:
	entityGlobalPosition = entity.global_position;
	entityRotation = entity.rotation;

static func normalize_angle(angle: float) -> float:
	var normalizedAngle = angle;
	while (normalizedAngle > PI): normalizedAngle -= 2 * PI;
	while (normalizedAngle < -PI): normalizedAngle += 2 * PI;
	return normalizedAngle;

static func get_ot_angle(delta: float, origin: float, target: float, baseRotSpeed: float, additionalRotSpeed: float) -> float:
	var angleDifference: float = target - origin;
	var newTarget: float = target; # New target angle
	# If angle difference curve contains -PI to PI jump,
	# define new target angles that are outside normal range
	if (angleDifference > PI): newTarget -= 2 * PI;
	if (angleDifference < -PI): newTarget += 2 * PI;
	
	var distance: float = newTarget - origin; # Angle difference curve length
	if is_equal_approx(distance, 0.0): return target; #If already close to target, return target
	
	var distanceSign := signf(distance); #Angle distance sign
	# Calculate rotation speed = [base rotation speed in the correct direction]
	# + [relative rotation speed] * [distance factor]
	var rotationSpeed: float = distanceSign * baseRotSpeed + additionalRotSpeed * (distance / PI); 
	# Calculate new rotation angle taking delta into account
	var rotationAngle = origin + rotationSpeed * delta;
	
	# Handle possible overshot
	if distanceSign == 1.0: rotationAngle = min(rotationAngle, newTarget);
	elif distanceSign == -1.0: rotationAngle = max(rotationAngle, newTarget);
	
	# Normalize resulting rotation angle (needed due to new target angle possibly being outside normal range)
	var normalizedRotationAngle: float = EntityRotation.normalize_angle(rotationAngle);
	
	# Return resulting rotation angle
	return normalizedRotationAngle;

func get_ot_angle_self(delta: float, targetAngle: float):
	return EntityRotation.get_ot_angle(delta, entityRotation, targetAngle, baseRotationSpeed, additionalRotationSpeed);

func get_angle_to_rotate_to_target_angle(delta: float, targetAngle: float) -> float:
	update_entity_properties();
	return get_ot_angle_self(delta, targetAngle);

func rotate_to_target_angle(delta: float, targetAngle: float) -> void:
	update_entity_properties();
	entity.rotation = get_ot_angle_self(delta, targetAngle);

func get_angle_to_rotate_to_target(delta: float, target: Vector2):
	update_entity_properties();
	var differenceVector: Vector2 = target - entityGlobalPosition;
	var targetAngle = differenceVector.angle();
	return get_ot_angle_self(delta, targetAngle);

func rotate_to_target(delta: float, target: Vector2):
	update_entity_properties();
	var differenceVector: Vector2 = target - entityGlobalPosition;
	var targetAngle = differenceVector.angle();
	entity.rotation = get_ot_angle_self(delta, targetAngle);
