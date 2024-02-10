extends Area2D;
class_name Weapon;

@export var lifeTime: float = 2;
@onready var SDTimer: Timer = $SDTimer;

func _ready():
	SDTimer.one_shot = true;
	SDTimer.wait_time = lifeTime;
	SDTimer.start();

func _on_sd_timer_timeout():
	print("SD timer timeout");
