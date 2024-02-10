extends Node2D;
class_name WeaponMeleePivot;

@onready var projectileContainer: Node2D = $"..";

func _ready():
	set_as_top_level(true);
	rotation = projectileContainer.global_rotation;
	global_position = projectileContainer.global_position;

func _process(delta):
	global_position = projectileContainer.global_position;
