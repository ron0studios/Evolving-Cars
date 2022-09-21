extends RigidBody2D


export(int,0,20,0.5) var turningspeed = 10


func _ready():
	angular_velocity = turningspeed

func _physics_process(_delta):
	angular_velocity = turningspeed
	pass
