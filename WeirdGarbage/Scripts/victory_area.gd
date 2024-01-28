class_name VictoryArea extends Area

export(String, FILE) var victoryScene:String

func _ready():
	self.connect("body_entered", self, "on_body_entered")

func on_body_entered(rhs:PhysicsBody) -> void:
	if rhs is CharacterController:
		# TODO: Check if the cat human has their food
		get_tree().change_scene(victoryScene)
