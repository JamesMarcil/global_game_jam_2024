class_name VictoryArea extends Area

export(String, FILE) var victoryScene:String

func _ready():
	self.connect("body_entered", self, "on_body_entered")
	self.connect("body_exited", self, "on_body_exited")

func on_body_entered(rhs:PhysicsBody) -> void:
	if rhs is CharacterController:
		if (rhs as CharacterController).has_all_snacks():
			get_tree().change_scene(victoryScene)
		else:
			pass # TODO: Show UI overlay

func on_body_exited(rhs:PhysicsBody) -> void:
	if rhs is CharacterController:
		pass # TODO: Hide UI overlay
