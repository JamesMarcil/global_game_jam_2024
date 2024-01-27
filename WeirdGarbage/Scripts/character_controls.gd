extends Node

class_name CharacterController

func _physics_process(delta:float) -> void:
	if Input.is_action_pressed("lean_forward"):
		print("Leaning forward bruh")
	elif Input.is_action_pressed("lean_backward"):
		print("Don't fall over bro")
	elif Input.is_action_pressed("lean_left"):
		print("Slide to the left")
	elif Input.is_action_pressed("lean_right"):
		print("Slide to the right")
