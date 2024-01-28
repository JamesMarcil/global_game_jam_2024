class_name VictoryArea extends Area

export(String, FILE) var victoryScene:String

func _ready():
	self.connect("body_entered", self, "on_body_entered")

func on_body_entered(rhs:PhysicsBody) -> void:
	if rhs is CharacterController:
		if (rhs as CharacterController).has_all_snacks():
			get_tree().change_scene(victoryScene)
		else:
			var need_snacks_overlay:NeedSnacksOverlay = rhs.get_node("../Control") as NeedSnacksOverlay
			if need_snacks_overlay:
				need_snacks_overlay.we_need_snacks()
