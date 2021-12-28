extends RigidBody2D

# the car-0

export var size = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var test = Genetic.generations[0][rand.randi_range(0,9)] # 0th generation's 0th car


	# EXAMPLE SHAPE (for testing)
	#testagon.append(Vector2(0,0))
	#testagon.append(Vector2(50,0))
	#testagon.append(Vector2(0,50))
	#testagon.append(Vector2(0,20))
	#testagon.append(Vector2(30,50))
	
	# add polygons
	for i in range(7):
		var newtriangle = CollisionPolygon2D.new()
		var arr = []
		arr.append(Vector2(test[0][i]*size,test[1][i]*size))
		arr.append(Vector2(test[0][i+1]*size,test[1][i+1]*size))
		arr.append(Vector2.ZERO)
		newtriangle.set_polygon(arr)
		add_child(newtriangle)
	var newtriangle = CollisionPolygon2D.new()
	var arr = []
	arr.append(Vector2(test[0][7]*size,test[1][7]*size))
	arr.append(Vector2(test[0][0]*size,test[1][0]*size))
	arr.append(Vector2.ZERO)
	
	# add wheels
	for i in range(8):
		var newwheel = load("res://wheel.tscn").instance()
		newwheel.position = Vector2(test[0][i]*size,test[1][i]*size)
		newwheel.get_node("PinJoint2D").node_a = self.get_path()
		if test[3][i] < 0.5:
			continue
		$wheels.add_child(newwheel)
		newwheel.get_node("CollisionShape2D").scale *= test[3][i]
		#newwheel.set_scale(Vector2(test[3][i],test[3][i]))
		
	
	#arr.append(Vector2(test[0][i]*size, test[1][i]*size))

	pass # Replace with function body.



func _physics_process(delta):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
