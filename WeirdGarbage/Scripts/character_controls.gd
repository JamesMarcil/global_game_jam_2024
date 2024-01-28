extends KinematicBody

class_name CharacterController

export(float) var tilt_acceleration:float
export(float) var tilt_deceleration:float
export(float) var max_velocity:float
export(float) var friction:float
export(float) var terminalVelocity:float
export(float) var turn_speed:float

signal catsGoBoom()

onready var CatHuman_AnimTree = self.get_node("CatHuman_Skeleton/AnimationTree")


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
	
var velocity:Vector3
	
func _ready():
	self.velocity = Vector3.ZERO

func _physics_process(delta:float) -> void:
	var movement_direction:Vector3 = Vector3()
	
	if Input.is_action_pressed("lean_forward"):
		movement_direction = Vector3.FORWARD
	elif Input.is_action_pressed("lean_backward"):
		movement_direction = Vector3.BACK
		
	if Input.is_action_pressed("lean_right"):
		movement_direction = Vector3.RIGHT
	elif Input.is_action_pressed("lean_left"):
		movement_direction = Vector3.LEFT
	
	var target_velocity:Vector3 = movement_direction * max_velocity
	
	var horizontal_velocity:Vector3 = velocity
	horizontal_velocity.y = 0
	
	var acceleration:float
	if movement_direction.dot(horizontal_velocity) > 0:
		acceleration = tilt_acceleration
	else:
		acceleration = tilt_deceleration
		
	horizontal_velocity = horizontal_velocity.linear_interpolate(target_velocity, acceleration * delta)
	
	self.velocity.x = horizontal_velocity.x
	self.velocity.z = horizontal_velocity.z
	
#	if Input.is_action_pressed("lean_forward"):
#		if self.velocity.z < 0:
#			self.velocity.z += tilt_deceleration
#			if self.velocity.z >= 0:
#				self.velocity.z = tilt_deceleration 
#		elif self.velocity.z < max_velocity:
#			self.velocity.z += tilt_acceleration
#			self.velocity.z = min(self.velocity.z, max_velocity)			
#	elif Input.is_action_pressed("lean_backward"):
#		if self.velocity.z > 0:
#			self.velocity.z -= tilt_deceleration
#			if self.velocity.z <= 0:
#				self.velocity.z = -tilt_deceleration
#		elif self.velocity.z > -max_velocity:
#			self.velocity.z -= tilt_acceleration
#			self.velocity.z = max(self.velocity.z, -max_velocity)
#	else:
#		self.velocity.z -= min(abs(self.velocity.z), friction) * sign(self.velocity.z)
#
#	if Input.is_action_pressed("lean_right"):
#		if self.velocity.x < 0:
#			self.velocity.x += tilt_deceleration
#			if self.velocity.x >= 0:
#				self.velocity.x = tilt_deceleration 
#		elif self.velocity.x < max_velocity:
#			self.velocity.x += tilt_acceleration
#			self.velocity.x = min(self.velocity.x, max_velocity)			
#	elif Input.is_action_pressed("lean_left"):
#		if self.velocity.x > 0:
#			self.velocity.x -= tilt_deceleration
#			if self.velocity.x <= 0:
#				self.velocity.x = -tilt_deceleration
#		elif self.velocity.x > -max_velocity:
#			self.velocity.x -= tilt_acceleration
#			self.velocity.x = max(self.velocity.x, -max_velocity)
#	else:
#		self.velocity.x -= min(abs(self.velocity.x), friction) * sign(self.velocity.x)
	
	var collision:KinematicCollision = self.move_and_collide(self.velocity)
	if collision:
		if self.velocity.length() >= terminalVelocity:
			emit_signal("catsGoBoom")
		else:
			self.velocity = self.velocity.bounce(collision.normal)
	
	if movement_direction.length() > 0:
		self.transform = self.transform.interpolate_with(self.transform.looking_at(self.transform.origin + movement_direction.normalized(), Vector3.UP), turn_speed * delta)
	
	#ANIMATION STUFF !!!!!!!!!!!!
	var Velocity_Average = min((abs(velocity.x)+abs(velocity.y)+abs(velocity.z))/3.0,max_velocity)/max_velocity
	CatHuman_AnimTree["parameters/Root/WalkDirection/blend_position"].y = sqrt(Velocity_Average)*10.0
	#CatHuman_AnimTree["parameters/Root/WalkDirection/blend_position"].x
	CatHuman_AnimTree["parameters/Root/Speed/scale"] = lerp(0.5,10.0,sqrt(Velocity_Average))
