extends RigidBody2D

# the car-0

export var size = 50
var cardata
var finished = false
var distance
var lifetime
var wheelsum = 0
var speed
var totalweight = 1
var bodyvolume = 0

signal done
# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()

	# rand colour for this car
	var red = rand.randf_range(0, 1)
	rand.randomize()
	var green = rand.randf_range(0, 1)
	rand.randomize()
	var blue = rand.randf_range(0, 1)
	rand.randomize()
	
	# this generates a nice pastel colour, not a horrid looking one
	var mix = [1, 1, 1]
	red = (red + mix[0]) / 2
	green = (green + mix[1]) / 2
	blue = (blue + mix[2]) / 2
	# alpha to 0.7 so multiple cars can be seen on top of each other
	var colour = Color(red, green, blue, 0.7)

	# EXAMPLE SHAPE (for testing)
	#testagon.append(Vector2(0,0))
	#testagon.append(Vector2(50,0))
	#testagon.append(Vector2(0,50))
	#testagon.append(Vector2(0,20))
	#testagon.append(Vector2(30,50))
	
	# add polygons
	for i in range(7):
		var newtriangle = CollisionPolygon2D.new()
		var polygonSprite = Polygon2D.new()
		var arr = []
		arr.append(Vector2(cardata[0][i]*size,cardata[1][i]*size))
		arr.append(Vector2(cardata[0][i+1]*size,cardata[1][i+1]*size))
		arr.append(Vector2.ZERO)
		newtriangle.set_polygon(arr)
		polygonSprite.set_polygon(arr)
		polygonSprite.color = colour
		add_child(newtriangle)
		add_child(polygonSprite)
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
		
		
		if cardata[3][i] < 0.1: # disabled 2nd gene in genome
			continue
			
		
		$wheels.add_child(newwheel)
		
		newwheel.gravity_scale *= cardata[4][i] # wheel weight
		totalweight += cardata[4][i]
		newwheel.get_node("Sprite").modulate = Color(cardata[4][i]/3,(3.01-cardata[4][i])/3.01,0)
		
		newwheel.get_node("Sprite").scale *= cardata[3][i]
		newwheel.get_node("CollisionShape2D").scale *= cardata[3][i] # wheel size
		wheelsum += newwheel.get_node("CollisionShape2D").scale.x
		
		#newwheel.set_scale(Vector2(cardata[3][i],cardata[3][i]))
	$idletimer.start()
		
	
	# calculate total body volume
	for i in get_children():
		if i is CollisionPolygon2D:
			var a = i.polygon[0].distance_to(i.polygon[1])
			var b = i.polygon[1].distance_to(i.polygon[2])
			var c = i.polygon[2].distance_to(i.polygon[0])
			bodyvolume += calcarea(a,b,c)
	
	pass # Replace with function body.


# uses heron's formula to calculate area of triangle
func calcarea(a,b,c):
	var p = (a+b+c)/2 # half the perimeter
	return sqrt(p*(p-a)*(p-b)*(p-c))

func _physics_process(_delta):
	
	
	#$debuglabel.text = str(linear_velocity)
	if linear_velocity.x > 20:
		$idletimer.stop()
		$idletimer.start()
	
	if global_position.x >= get_parent().get_parent().get_node("end").rect_global_position.x and finished == false:
		emit_signal("done")
		finished = true
		distance = get_parent().get_parent().get_node("end").rect_global_position.x
		lifetime = 1000-$idletimer.time_left 
		$debuglabel.text = str(lifetime)


func _on_idletimer_timeout():
	if finished == false:
		emit_signal("done")
		finished = true
	
		
		lifetime = 30 # big number
		distance = global_position.x
		$debuglabel.text = str(lifetime)
