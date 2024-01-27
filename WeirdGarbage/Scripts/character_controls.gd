extends KinematicBody

class_name CharacterController

export(float) var tilt_acceleration:float
export(Vector3) var max_velocity:Vector3
export(Vector3) var max_acceleration:Vector3

var velocity:Vector3 = Vector3.ZERO
var acceleration:Vector3 = Vector3.ZERO

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
	self.acceleration = Vector3.ZERO

func _physics_process(delta:float) -> void:
	if Input.is_action_pressed("lean_forward"):
		acceleration += tilt_acceleration * Vector3.FORWARD * delta
	elif Input.is_action_pressed("lean_backward"):
		acceleration += tilt_acceleration * Vector3.BACK * delta
	
	if Input.is_action_pressed("lean_left"):
		acceleration += tilt_acceleration * Vector3.LEFT * delta
	elif Input.is_action_pressed("lean_right"):
		acceleration += tilt_acceleration * Vector3.RIGHT * delta
	
	acceleration = vector3_min(acceleration, max_acceleration)
	
	velocity += acceleration * delta
	velocity = vector3_min(velocity, max_velocity)
	
	velocity = self.move_and_slide(velocity)
