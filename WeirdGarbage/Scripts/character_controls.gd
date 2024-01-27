extends KinematicBody

class_name CharacterController

func _physics_process(delta:float) -> void:
	if Input.is_action_pressed("lean_forward"):
		self.move_and_slide(Vector3(0,0,1))
	elif Input.is_action_pressed("lean_backward"):
		self.move_and_slide(Vector3(0,0,-1))
	
	if Input.is_action_pressed("lean_left"):
		self.move_and_slide(Vector3(1,0,0))
	elif Input.is_action_pressed("lean_right"):
		self.move_and_slide(Vector3(-1,0,0))
