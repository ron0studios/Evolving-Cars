extends RigidBody2D

# the car-0

export var size = 50
var cardata
var finished = false
var distance
var lifetime
var wheelsum = 0

signal done
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
	var _newtriangle = CollisionPolygon2D.new()
	var arr = []
	arr.append(Vector2(cardata[0][7]*size,cardata[1][7]*size))
	arr.append(Vector2(cardata[0][0]*size,cardata[1][0]*size))
	arr.append(Vector2.ZERO)
	
	# add wheels
	for i in range(8):
		var newwheel = load("res://wheel.tscn").instance()
		newwheel.position = Vector2(cardata[0][i]*size,cardata[1][i]*size)
		newwheel.get_node("PinJoint2D").node_a = self.get_path()
		if cardata[2][i] == 0:
			continue
		$wheels.add_child(newwheel)
		newwheel.mass *= cardata[4][i] # wheel weight
		newwheel.get_node("CollisionShape2D").scale *= cardata[3][i] # wheel size
		wheelsum += newwheel.get_node("CollisionShape2D").scale.x
		
		#newwheel.set_scale(Vector2(cardata[3][i],cardata[3][i]))
	$idletimer.start()
	pass # Replace with function body.



func _physics_process(_delta):
	
	
	#$debuglabel.text = str(linear_velocity)
	if linear_velocity.x > 20:
		$idletimer.stop()
		$idletimer.start()
	
	if global_position.x >= get_parent().get_parent().get_node("end").rect_global_position.x and finished == false:
		emit_signal("done")
		finished = true
		distance = get_parent().get_parent().get_node("end").rect_global_position.x
		lifetime = 1000-$lifetime.time_left 
		$debuglabel.text = str(lifetime)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_idletimer_timeout():
	if finished == false:
		emit_signal("done")
		finished = true
	
		
		lifetime = 30 # big number
		distance = global_position.x
		$debuglabel.text = str(lifetime)
	pass # Replace with function body.
