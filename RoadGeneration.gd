extends StaticBody2D


var _pressed := false
var _current_line: Line2D


# collision script i stole
export (Array, NodePath) var lines_to_follow = [NodePath("Line2D")]


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.position.y < 512:
		_pressed = event.pressed
		
		if _pressed:
			_current_line = Line2D.new()
			_current_line.default_color = Color.white
			_current_line.width = 10.0
			self.add_child(_current_line)
		else:
			var path_to_line = _current_line.get_path()
			var num_segments : int = 0
			var line_points : Array = []
			var line : Line2D = get_node(path_to_line)
			var translated_points : Array = []
			for i in range(0, len(line.points)):
				translated_points.append(line.points[i] + line.position)
			line_points.append_array(translated_points)
			num_segments += len(line.points)
			line_points.append(Vector2(419430.4, 419430.4))
			for current_segment in range(0, num_segments):
				if line_points[current_segment+1] == Vector2(419430.4, 419430.4) or line_points[current_segment] == Vector2(419430.4, 419430.4):
					continue
				var segment_collider := CollisionShape2D.new()
				segment_collider.shape = SegmentShape2D.new()
				segment_collider.shape.a = line_points[current_segment]
				segment_collider.shape.b = line_points[current_segment+1]
				add_child(segment_collider)
	
	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(get_global_mouse_position())
