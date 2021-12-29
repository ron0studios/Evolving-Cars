extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 3
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
		newthing.cardata = Genetic.generations[-1][i]
		newthing.call_deferred("set_global_position",Vector2(184,320))
		$cars.call_deferred("add_child",newthing)
	pass # Replace with function body.


func _on_HScrollBar_value_changed(value):
	$cam.zoom = Vector2(value,value)
	$HUD/zoomlabel.text = "Zoom: "+str($HUD/HScrollBar.max_value-value)
	pass # Replace with function body.


func _on_gentimelimit_timeout():
	var all = []
	for i in $cars.get_children():
		
		# fitness variables
		var wheelsum = 0
		var max_pos = 0
		var lifetime = 0
		
		for j in i.get_node("wheels").get_children():
			wheelsum += j.get_node("CollisionShape2D").scale.x
		print(wheelsum)
		all.append(Genetic.fitness($start.rect_global_position.distance_to(i.global_position), wheelsum,2048))
	Genetic.genfitness.append(all)
	
	Genetic.nextgen(Genetic.generations[-1])
	
	# wipeout (exterminate) all cars
	for i in $cars.get_children():
		i.queue_free()
	$HUD/Label.text = "Generation: " + str(int($HUD/Label.text[-1])+1)
	_on_Button_pressed()
	pass # Replace with function body.
