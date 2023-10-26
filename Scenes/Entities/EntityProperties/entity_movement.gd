extends Node2D;
class_name EntityMovement;

# --- Entity ---
@onready var fEntity: CharacterBody2D = $"..";

# --- Entity properties ---
var fEntityGlobalPosition: Vector2 = Vector2.ZERO;
var fEntityVelocity: Vector2 = Vector2.ZERO;

# --- Individual properties ---
# Max walk speed
@export var fWalkSpeed: float = 100;
# Max run speed
@export var fRunSpeed: float = 180;
# Walk acceleration
@export var fWalkAcceleration: float = 300;
# Run acceleration
@export var fRunAcceleration: float = 450;
# Deceleration
@export var fFriction: float = 300;

# Modifiers
@export var fSpeedModifier: float = 1.0;
@export var fAccelerationModifier: float = 1.0;
@export var fFrictionModifier: float = 1.0;

func get_walk_speed() -> float:
	return fWalkSpeed * fSpeedModifier;

func get_run_speed() -> float:
	return fRunSpeed * fSpeedModifier;

func get_walk_acceleration() -> float:
	return fWalkAcceleration * fAccelerationModifier;

func get_run_acceleration() -> float:
	return fRunAcceleration * fAccelerationModifier;

func get_friction() -> float:
	return fFriction * fFrictionModifier;

func set_speed_modifier(modifier: float) -> void:
	fSpeedModifier = modifier;

func set_acceleration_modifier(modifier: float) -> void:
	fAccelerationModifier = modifier;

func set_friction_modifier(modifier: float) -> void:
	fFrictionModifier = modifier;

func _ready() -> void:
	update_entity_properties();

# Set Entity properties fields according to Entity
func update_entity_properties() -> void:
	fEntityGlobalPosition = fEntity.global_position;
	fEntityVelocity = fEntity.velocity;

func get_velocity_to_walk_in_direction(delta: float, direction: Vector2) -> Vector2:
	if (direction == Vector2.ZERO):
		return get_velocity_to_stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var limitLengthValue = get_walk_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_walk_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	return rVelocity;

func walk_in_direction(delta: float, direction: Vector2) -> bool:
	if (direction == Vector2.ZERO):
		return stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var limitLengthValue = get_walk_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_walk_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	fEntity.velocity = rVelocity;
	var collided: bool = fEntity.move_and_slide();
	return collided;

func get_velocity_to_run_in_direction(delta: float, direction: Vector2) -> Vector2:
	if (direction == Vector2.ZERO):
		return get_velocity_to_stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var limitLengthValue = get_run_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_run_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	return rVelocity;

func run_in_direction(delta: float, direction: Vector2) -> bool:
	if (direction == Vector2.ZERO):
		return stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var limitLengthValue = get_run_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_run_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	fEntity.velocity = rVelocity;
	var collided: bool = fEntity.move_and_slide();
	return collided;

func get_velocity_to_stop(delta: float) -> Vector2:
	update_entity_properties();
	if (fEntityVelocity == Vector2.ZERO):
		return Vector2.ZERO;
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var velocityDirection: Vector2 = fEntityVelocity / velocityLength;
	var decelerationLength: float = get_friction() * delta;
	if (velocityLength > decelerationLength) :
		rVelocity += -decelerationLength * velocityDirection;
	else:
		rVelocity = Vector2.ZERO;
	return rVelocity;

func stop(delta: float) -> bool:
	update_entity_properties();
	if (fEntityVelocity == Vector2.ZERO):
		return fEntity.move_and_slide();
	var rVelocity: Vector2 = fEntityVelocity;
	var velocityLength: float = fEntityVelocity.length();
	var velocityDirection: Vector2 = fEntityVelocity / velocityLength;
	var decelerationLength: float = get_friction() * delta;
	if (velocityLength > decelerationLength) :
		rVelocity += -decelerationLength * velocityDirection;
	else:
		rVelocity = Vector2.ZERO;
	fEntity.velocity = rVelocity;
	var collided: bool = fEntity.move_and_slide();
	return collided;
