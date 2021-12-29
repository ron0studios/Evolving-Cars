extends Node2D


var genpassed = 0


func _ready():
	Engine.time_scale = 3
	
	# WHY ARE OPTION BUTTONS BROKEY
	$HUD/FitnessButton.add_item("Balanced", 0)
	$HUD/FitnessButton.add_item("Balanced but dumb", 1)
	$HUD/FitnessButton.add_item("Wheels suck", 3)
	$HUD/FitnessButton.add_item("We like wheels", 2)
	$HUD/FitnessButton.add_item("Speed demon", 4)

func _physics_process(_delta):
	# num cars that have finished
	var donecount = 0
	for i in $cars.get_children():
		if i.finished == true:
			donecount += 1
	if donecount == Genetic.gensize:
		end()

func _on_StartButton_pressed():
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
	
	$HUD/GenLabel.text = "Generation: " + str(genpassed)


func _on_HScrollBar_value_changed(value):
	$cam.zoom = Vector2(value,value)
	$HUD/ZoomLabel.text = "Zoom: "+str($HUD/HScrollBar.max_value-value)


# terminate simulation
func end():
	var all = []
	for i in $cars.get_children():
		all.append(Genetic.fitness(i.distance,i.wheelsum,i.lifetime))
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
