extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $gentimelimit.time_left > 0:
		$HUD/timelabel.text = "Time left: " + str($gentimelimit.time_left)
	pass


func _on_Button_pressed():
	$gentimelimit.start()
	for i in range(Genetic.gensize):
		var newthing = preload("res://thing.tscn").instance()
		
		newthing.call_deferred("set_global_position",Vector2(184,320))
		$cars.call_deferred("add_child",newthing)
	pass # Replace with function body.


func _on_HScrollBar_value_changed(value):
	$cam.zoom = Vector2(value,value)
	$HUD/zoomlabel.text = "Zoom: "+str($HUD/HScrollBar.max_value-value)
	pass # Replace with function body.


func _on_gentimelimit_timeout():
	for i in $cars.get_children():
		var wheelsum = 0
		for j in i.get_node("wheels").get_children():
			wheelsum += j.get_node("CollisionShape2D").scale.x
		print(wheelsum)
		i.get_node("debuglabel").text="Fitness = " + str(Genetic.fitness($start.rect_global_position.distance_to(i.global_position), wheelsum,2048))
	pass # Replace with function body.
