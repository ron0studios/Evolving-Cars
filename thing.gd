extends RigidBody2D

# the car-0

export var size = 50
var cardata
var finished = false
var fintime 

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()


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
		arr.append(Vector2(cardata[0][i]*size,cardata[1][i]*size))
		arr.append(Vector2(cardata[0][i+1]*size,cardata[1][i+1]*size))
		arr.append(Vector2.ZERO)
		newtriangle.set_polygon(arr)
		add_child(newtriangle)
	var newtriangle = CollisionPolygon2D.new()
	var arr = []
	arr.append(Vector2(cardata[0][7]*size,cardata[1][7]*size))
	arr.append(Vector2(cardata[0][0]*size,cardata[1][0]*size))
	arr.append(Vector2.ZERO)
	
	# add wheels
	for i in range(8):
		var newwheel = load("res://wheel.tscn").instance()
		newwheel.position = Vector2(cardata[0][i]*size,cardata[1][i]*size)
		newwheel.get_node("PinJoint2D").node_a = self.get_path()
		if cardata[3][i] < 0.2:
			continue
		$wheels.add_child(newwheel)
		newwheel.get_node("CollisionShape2D").scale *= cardata[3][i] # wheel size
		
		#newwheel.set_scale(Vector2(cardata[3][i],cardata[3][i]))
		
	
	#arr.append(Vector2(cardata[0][i]*size, cardata[1][i]*size))

	pass # Replace with function body.



func _physics_process(delta):
	if global_position.x >= get_parent().get_parent().get_node("end").rect_global_position.x:
		finished = true
		fintime = get_parent().get_parent().get_node("gentimelimit").time_left
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
