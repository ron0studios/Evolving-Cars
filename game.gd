extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	for i in range(10):
		yield(get_tree().create_timer(0.1),"timeout")
		var newthing = preload("res://thing.tscn").instance()
		
		newthing.call_deferred("set_global_position",Vector2(184,320))
		get_parent().call_deferred("add_child",newthing)
	pass # Replace with function body.
