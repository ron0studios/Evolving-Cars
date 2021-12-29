extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var genpassed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 3
	pass # Replace with function body.

func _physics_process(delta):
	# num cars that have finished
	var donecount = 0
	for i in $cars.get_children():
		if i.finished == true:
			donecount += 1
	if donecount == Genetic.gensize:
		end()

func _on_Button_pressed():
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
	$HUD/Label.text = "Generation: " + str(genpassed)
	_on_Button_pressed()
