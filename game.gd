extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(10):
		yield(get_tree().create_timer(0.1),"timeout")
		var newthing = preload("res://thing.tscn").instance()
		
		newthing.call_deferred("set_global_position",Vector2(rand_range(0,1000),0))
		get_parent().call_deferred("add_child",newthing)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
