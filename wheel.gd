extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int,0,20,0.5) var turningspeed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	
	angular_velocity = turningspeed
	pass # Replace with function body.

func _physics_process(delta):
	angular_velocity = turningspeed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
