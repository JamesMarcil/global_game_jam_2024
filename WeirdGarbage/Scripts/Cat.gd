extends RigidBody


onready var BlastAwayPoint = get_node("../../../Spine2")
onready var BlastAwayParent = get_node("../../../../../../../../CatHolder")
onready var CatBod_00 = get_node("Cat_00")

onready var CatBodies = {
	0:CatBod_00,
	1:CatBod_00,
	2:CatBod_00,
	3:CatBod_00,
	4:CatBod_00
}

var Blasted = 0
const Hit_Force_Range = [2.0,8.0]
const Hit_Force_Angle_Range = 20.0

var Wiggle = 0


func RandomNum(type,range1,range2):#Creates Random Numbers
	var Output
	var Generator = RandomNumberGenerator.new()
	Generator.randomize()
	if type == "float":
		Output = Generator.randf_range(range1,range2)
	elif type == "int":
		Output = Generator.randi_range(range1,range2)
	return Output


func BlastOff():
	var OldPos = self.global_transform.origin
	var OldBasis = self.global_transform.basis
	var new_parent = BlastAwayParent
	get_parent().remove_child(self)
	new_parent.add_child(self)
	self.global_transform.origin = OldPos
	self.global_transform.basis = OldBasis
	
	var ForceVector = BlastAwayPoint.global_transform.origin.direction_to(self.global_transform.origin)
	self.set_linear_velocity(ForceVector*lerp(Hit_Force_Range[0],Hit_Force_Range[1],RandomNum("float",0.0,1.0)))
	self.set_gravity_scale(1.0)
	var ForceAngle = Vector3(RandomNum("float",-Hit_Force_Angle_Range,Hit_Force_Angle_Range),RandomNum("float",-Hit_Force_Angle_Range,Hit_Force_Angle_Range),RandomNum("float",-Hit_Force_Angle_Range,Hit_Force_Angle_Range))
	self.set_angular_velocity(ForceAngle)


func _ready():
	CatBodies[RandomNum("int",0,len(CatBodies)-1)].visible = true


func _process(_delta):
	if Input.is_action_just_pressed("Test_Store_Generate"):
		if Blasted == 0:
			BlastOff()
			Blasted = 1
