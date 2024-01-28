class_name CatSnacks extends Area

var has_been_acquired:bool = false


func _ready() -> void:
	self.has_been_acquired = false
	self.connect("body_entered", self, "on_body_entered")


func on_body_entered(rhs:PhysicsBody) -> void:
	if rhs is CharacterController and !has_been_acquired:
		has_been_acquired = true
		
		(rhs as CharacterController).acquire_snack()
		
		
		self.get_node("../").queue_free()#Delete Self
