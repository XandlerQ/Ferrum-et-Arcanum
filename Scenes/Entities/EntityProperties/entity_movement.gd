extends Node2D;
class_name EntityMovement;

# --- Entity ---
@onready var entity: CharacterBody2D = $"..";

# --- Entity properties ---
var entityGlobalPosition: Vector2 = Vector2.ZERO;
var entityVelocity: Vector2 = Vector2.ZERO;

# --- Individual properties ---
# Max walk speed
@export var walkSpeed: float = 100;
# Max run speed
@export var runSpeed: float = 180;
# Dash speed
@export var dashSpeed: float = 250;
# Walk acceleration
@export var walkAcceleration: float = 300;
# Run acceleration
@export var runAcceleration: float = 450;
# Deceleration
@export var friction: float = 300;

# Timer
@onready var dashTimer: Timer = $DashTimer;
@export var dashCooldown: float = 1;

# Modifiers
@export var speedModifier: float = 1.0;
@export var accelerationModifier: float = 1.0;
@export var frictionModifier: float = 1.0;

func _ready() -> void:
	dashTimer.one_shot = true;
	dashTimer.wait_time = dashCooldown;
	update_entity_properties();

func get_walk_speed() -> float:
	return walkSpeed * speedModifier;

func get_run_speed() -> float:
	return runSpeed * speedModifier;

func get_dash_speed() -> float:
	return dashSpeed * speedModifier;

func get_walk_acceleration() -> float:
	return walkAcceleration * accelerationModifier;

func get_run_acceleration() -> float:
	return runAcceleration * accelerationModifier;

func get_friction() -> float:
	return friction * frictionModifier;

func set_speed_modifier(modifier: float) -> void:
	speedModifier = modifier;

func set_acceleration_modifier(modifier: float) -> void:
	accelerationModifier = modifier;

func set_friction_modifier(modifier: float) -> void:
	frictionModifier = modifier;

# Set Entity properties fields according to Entity
func update_entity_properties() -> void:
	entityGlobalPosition = entity.global_position;
	entityVelocity = entity.velocity;

func get_velocity_to_walk_in_direction(delta: float, direction: Vector2) -> Vector2:
	if (direction == Vector2.ZERO):
		return get_velocity_to_stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var limitLengthValue = get_walk_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_walk_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	return rVelocity;

func walk_in_direction(delta: float, direction: Vector2) -> void:
	if (direction == Vector2.ZERO):
		return stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var limitLengthValue = get_walk_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_walk_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	entity.velocity = rVelocity;

func get_velocity_to_run_in_direction(delta: float, direction: Vector2) -> Vector2:
	if (direction == Vector2.ZERO):
		return get_velocity_to_stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var limitLengthValue = get_run_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_run_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	return rVelocity;

func run_in_direction(delta: float, direction: Vector2) -> void:
	if (direction == Vector2.ZERO):
		return stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var limitLengthValue = get_run_speed();
	if (velocityLength > limitLengthValue):
		limitLengthValue = velocityLength - get_friction() * delta;
	var deltaVelocity: Vector2 = (get_run_acceleration() * delta) * direction;
	rVelocity += deltaVelocity;
	rVelocity = rVelocity.limit_length(limitLengthValue);
	entity.velocity = rVelocity;

func get_velocity_to_dash_in_direction(delta: float, direction: Vector2) -> Vector2:
	if (direction == Vector2.ZERO or !dashTimer.is_stopped()):
		return get_velocity_to_stop(delta);
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity / 2;
	rVelocity += get_dash_speed() * direction;
	return rVelocity;

func dash_in_direction(delta: float, direction: Vector2) -> void:
	if (direction == Vector2.ZERO or !dashTimer.is_stopped()):
		return stop(delta);
	dashTimer.start();
	update_entity_properties();
	var rVelocity: Vector2 = entityVelocity / 2;
	rVelocity += get_dash_speed() * direction;
	entity.velocity = rVelocity;

func get_velocity_to_stop(delta: float) -> Vector2:
	update_entity_properties();
	if (entityVelocity == Vector2.ZERO):
		return Vector2.ZERO;
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var velocityDirection: Vector2 = entityVelocity / velocityLength;
	var decelerationLength: float = get_friction() * delta;
	if (velocityLength > decelerationLength) :
		rVelocity += -decelerationLength * velocityDirection;
	else:
		rVelocity = Vector2.ZERO;
	return rVelocity;

func stop(delta: float) -> void:
	update_entity_properties();
	if (entityVelocity == Vector2.ZERO):
		return entity.move_and_slide();
	var rVelocity: Vector2 = entityVelocity;
	var velocityLength: float = entityVelocity.length();
	var velocityDirection: Vector2 = entityVelocity / velocityLength;
	var decelerationLength: float = get_friction() * delta;
	if (velocityLength > decelerationLength) :
		rVelocity += -decelerationLength * velocityDirection;
	else:
		rVelocity = Vector2.ZERO;
	entity.velocity = rVelocity;
