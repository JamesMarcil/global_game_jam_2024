extends ImmediateGeometry

export(float) var radius
export(int) var num_subdivisions
export(float) var angle_to_fall_over

func _process(delta:float) -> void:
	self.clear()
	
	var increment_in_degrees:float = 360 / num_subdivisions
	
	self.begin(Mesh.PRIMITIVE_LINE_LOOP)
	for value in range(0, num_subdivisions + 1):
		var value_in_degrees:float = value * increment_in_degrees
		var value_in_radians:float = deg2rad(value_in_degrees)
		self.add_vertex(self.transform.origin + Vector3(radius * cos(value_in_radians), 0, radius * sin(value_in_radians)))
	self.end()
	
	self.begin(Mesh.PRIMITIVE_LINE_LOOP)
	for value in range(0, num_subdivisions + 1):
		var value_in_degrees:float = value * increment_in_degrees
		var value_in_radians:float = deg2rad(value_in_degrees)
		self.add_vertex(self.transform.origin + Vector3(0, radius * cos(value_in_radians), radius * sin(value_in_radians)))
	self.end()
	
	self.begin(Mesh.PRIMITIVE_LINE_LOOP)
	for value in range(0, num_subdivisions + 1):
		var value_in_degrees:float = value * increment_in_degrees
		var value_in_radians:float = deg2rad(value_in_degrees)
		self.add_vertex(self.transform.origin + Vector3(radius * cos(value_in_radians), radius * sin(value_in_radians), 0))
	self.end()
	
	self.begin(Mesh.PRIMITIVE_LINES)
	self.add_vertex(self.transform.origin + Vector3(0, radius, 0))
	self.add_vertex(self.transform.origin + Vector3(0, -radius, 0))
	self.end()
	
	var point_on_sphere = self.transform.origin + Vector3(radius * cos(deg2rad(angle_to_fall_over)), radius * sin(deg2rad(angle_to_fall_over)), 0)
	var center_at_point = Vector3(self.transform.origin.x, point_on_sphere.y, self.transform.origin.z)
	var radius_at_point = abs(point_on_sphere.distance_to(center_at_point))
	self.begin(Mesh.PRIMITIVE_LINE_LOOP)
	for value in range(0, num_subdivisions + 1):
		var value_in_degrees:float = value * increment_in_degrees
		var value_in_radians:float = deg2rad(value_in_degrees)
		self.add_vertex(center_at_point + Vector3(radius_at_point * cos(value_in_radians), 0, radius_at_point * sin(value_in_radians)))
	self.end()
	
