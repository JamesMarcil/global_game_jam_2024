class_name EnableRagdoll extends Skeleton

export(Array, String) var bones

func _ready() -> void:
	print(bones)
	self.physical_bones_start_simulation(bones)
