extends KinematicBody

class_name CharacterController

export(float) var tilt_acceleration:float
export(float) var tilt_deceleration:float
export(float) var max_velocity:float
export(float) var friction:float

var velocity:Vector3 = Vector3.ZERO

static func vector3_max(a:Vector3, b:Vector3) -> Vector3:
	var result:Vector3 = Vector3()
	result.x = max(a.x, b.x)
	result.y = max(a.y, b.y)
	result.z = max(a.z, b.z)
	return result
	
static func vector3_min(a:Vector3, b:Vector3) -> Vector3:
	var result:Vector3 = Vector3()
	result.x = min(a.x, b.x)
	result.y = min(a.y, b.y)
	result.z = min(a.z, b.z)
	return result
	
func _ready():
	self.velocity = Vector3.ZERO

func _physics_process(delta:float) -> void:
	if Input.is_action_pressed("lean_forward"):
		if self.velocity.z < 0:
			self.velocity.z += tilt_deceleration
			if self.velocity.z >= 0:
				self.velocity.z = tilt_deceleration 
		elif self.velocity.z < max_velocity:
			self.velocity.z += tilt_acceleration
			self.velocity.z = min(self.velocity.z, max_velocity)			
	elif Input.is_action_pressed("lean_backward"):
		if self.velocity.z > 0:
			self.velocity.z -= tilt_deceleration
			if self.velocity.z <= 0:
				self.velocity.z = -tilt_deceleration
		elif self.velocity.z > -max_velocity:
			self.velocity.z -= tilt_acceleration
			self.velocity.z = max(self.velocity.z, -max_velocity)
	else:
		self.velocity.z -= min(abs(self.velocity.z), friction) * sign(self.velocity.z)
	
	if Input.is_action_pressed("lean_left"):
		if self.velocity.x < 0:
			self.velocity.x += tilt_deceleration
			if self.velocity.x >= 0:
				self.velocity.x = tilt_deceleration 
		elif self.velocity.x < max_velocity:
			self.velocity.x += tilt_acceleration
			self.velocity.x = min(self.velocity.x, max_velocity)			
	elif Input.is_action_pressed("lean_right"):
		if self.velocity.x > 0:
			self.velocity.x -= tilt_deceleration
			if self.velocity.x <= 0:
				self.velocity.x = -tilt_deceleration
		elif self.velocity.x > -max_velocity:
			self.velocity.x -= tilt_acceleration
			self.velocity.x = max(self.velocity.x, -max_velocity)
	else:
		self.velocity.x -= min(abs(self.velocity.x), friction) * sign(self.velocity.x)
	
	velocity = self.move_and_slide(velocity)
