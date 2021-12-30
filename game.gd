extends Node2D


var genpassed = 0


func _ready():
	Engine.time_scale = 5
	
	# WHY ARE OPTION BUTTONS BROKEY
	$HUD/FitnessButton.add_item("Balanced", 0)
	$HUD/FitnessButton.add_item("Minimize volume", 1)
	$HUD/FitnessButton.add_item("Maximize wheels", 2)
	$HUD/FitnessButton.add_item("Maximize distance", 3)
	$HUD/FitnessButton.add_item("Maximize weight", 4)
	
	
	

func _physics_process(_delta):
	$HUD/gentimelabel.text = "Time left: " + str(stepify($gentimelimit.time_left,0.01))
	
	if Input.is_key_pressed(KEY_Q):
		if $cam.zoom.x >= 0.2:
			$cam.zoom -= Vector2(0.1,0.1)
		else:
			$cam.zoom = Vector2(0.1,0.1)
		$HUD/ZoomLabel.text = "Zoom: "+str($cam.zoom)
		$HUD/HScrollBar.value = $cam.zoom.x
	elif Input.is_key_pressed(KEY_E):
		$cam.zoom += Vector2(0.1,0.1)
		$HUD/ZoomLabel.text = "Zoom: "+str($cam.zoom)
		$HUD/HScrollBar.value = $cam.zoom.x
		
	if Input.is_key_pressed(KEY_D):
		$cam.position.x += 15
	elif Input.is_key_pressed(KEY_A):
		$cam.position.x -= 15
	if Input.is_key_pressed(KEY_W):
		$cam.position.y -= 15
	elif Input.is_key_pressed(KEY_S):
		$cam.position.y += 15
		
		
	



func _on_StartButton_pressed():
	$gentimelimit.wait_time = Genetic.max_life
	$gentimelimit.start()
	for i in range(Genetic.gensize):
		var newthing = preload("res://thing.tscn").instance()
		newthing.cardata = Genetic.generations[-1][i]
		newthing.call_deferred("set_global_position",Vector2(184,320))
		$cars.call_deferred("add_child",newthing)


func _on_ResetButton_pressed():
	genpassed = 0
	Genetic.generations = []
	Genetic.generations.append(Genetic.randomgen())
	Genetic.genfitness = []
	
	for i in $cars.get_children():
		i.queue_free()
	
	for i in $RoadGeneration.get_children():
		i.queue_free()
	
	$gentimelimit.stop()
	$HUD/GenLabel.text = "Generation: " + str(genpassed)


func _on_HScrollBar_value_changed(value):
	$cam.zoom = Vector2(value,value)
	$HUD/ZoomLabel.text = "Zoom: "+str($cam.zoom)


# terminate simulation
func end():
	var all = []
	for i in $cars.get_children():
		var distance = i.global_position.x - $start.rect_global_position.x
		var wheelsum = i.wheelsum
		var bodyvolume = i.bodyvolume
		var weight = i.totalweight
		all.append(Genetic.fitness(distance,wheelsum,bodyvolume,weight))
	Genetic.genfitness.append(all)
	
	Genetic.nextgen(Genetic.generations[-1])
	
	# wipeout (exterminate) all cars
	for i in $cars.get_children():
		i.queue_free()
	genpassed += 1
	$HUD/GenLabel.text = "Generation: " + str(genpassed)
	_on_StartButton_pressed()


func _on_GenSizeSlider_value_changed(value):
	$HUD/GenSizeLabel.text = "Generations size = " + str(value)
	Genetic.gensize = int(value)
	
	# reset generations but keep the road
	genpassed = 0
	Genetic.generations = []
	Genetic.generations.append(Genetic.randomgen())
	Genetic.genfitness = []
	
	for i in $cars.get_children():
		i.queue_free()
	
	$HUD/GenLabel.text = "Generation: " + str(genpassed)


func _on_FitnessButton_item_selected(index):
	Genetic.fitness_id = index



func _on_gentimelimit_timeout():
	end()
	pass # Replace with function body.
