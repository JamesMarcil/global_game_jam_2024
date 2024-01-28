class_name CatSnacks extends Area

var has_been_acquired:bool = false


func RandomNum(type,range1,range2):#Creates Random Numbers
	var Output
	var Generator = RandomNumberGenerator.new()
	Generator.randomize()
	if type == "float":
		Output = Generator.randf_range(range1,range2)
	elif type == "int":
		Output = Generator.randi_range(range1,range2)
	return Output


func _ready() -> void:
	self.has_been_acquired = false
	self.connect("body_entered", self, "on_body_entered")


func on_body_entered(rhs:PhysicsBody) -> void:
	if rhs is CharacterController and !has_been_acquired:
		has_been_acquired = true
		
		(rhs as CharacterController).acquire_snack()
		
		
		var FoodMesh = self.get_node("../FoodHeight/FoodHover/MeshInstance")
		FoodMesh.scale *= 0.5
		var new_parent
		var RightOrLeft = RandomNum("int",0,1)
		if RightOrLeft == 0:
			new_parent = get_node("../../../../CatHuman/KinematicBody/CatHuman_Skeleton/Human_Bomes/Skeleton/HandL")
			get_node("../../../../CatHuman/KinematicBody").SnacksHeldL += 1
		else:
			new_parent = get_node("../../../../CatHuman/KinematicBody/CatHuman_Skeleton/Human_Bomes/Skeleton/HandR")
			get_node("../../../../CatHuman/KinematicBody").SnacksHeldR += 1
		self.get_node("../FoodHeight/FoodHover").remove_child(FoodMesh)
		new_parent.add_child(FoodMesh)
		var PosRange = 0.1
		if RightOrLeft == 0:
			FoodMesh.transform.origin.x = 0.0
			FoodMesh.transform.origin.y = 0.1*get_node("../../../../CatHuman/KinematicBody").SnacksHeldL
			FoodMesh.transform.origin.z = 0.0#RandomNum("float",-PosRange,PosRange)
		else:
			FoodMesh.transform.origin.x = 0.0
			FoodMesh.transform.origin.y = 0.1*get_node("../../../../CatHuman/KinematicBody").SnacksHeldR
			FoodMesh.transform.origin.z = 0.0#RandomNum("float",-PosRange,PosRange)
		get_node("../../../../CatHuman/KinematicBody").SnacksHeld.append(FoodMesh)
		
		
		self.get_node("../").queue_free()#Delete Self
