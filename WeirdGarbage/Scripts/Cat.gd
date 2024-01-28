extends RigidBody


onready var BlastAwayPoint = get_node("../../../../../")#get_node("../../../Spine2")
onready var BlastAwayParent = get_node("../../../../../../../../CatHolder")
onready var CatBod_00 = get_node("Cat_00")
onready var CatBod_01 = get_node("Cat_01")

onready var CatBodies = {
	0:CatBod_00,
	1:CatBod_01,
	2:CatBod_00,
	3:CatBod_01
}

onready var CatColors = {
	0:[Color(0.117647, 0.117647, 0.117647),Color(0.117647, 0.117647, 0.117647)],#Black
	1:[Color(0.894531, 0.882984, 0.863083),Color(0.894531, 0.882984, 0.863083)],#White
	2:[Color(0.765625, 0.57784, 0.254211),Color(0.765625, 0.57784, 0.254211)],#Oragne
	3:[Color(0.394531, 0.339749, 0.254288),Color(0.394531, 0.339749, 0.254288)],#Brown
	4:[Color(0.300781, 0.291676, 0.281982),Color(0.300781, 0.291676, 0.281982)],#Grey
	5:[Color(0.117647, 0.117647, 0.117647),Color(0.894531, 0.882984, 0.863083)],#Black Tux
	6:[Color(0.765625, 0.57784, 0.254211),Color(0.894531, 0.882984, 0.863083)],#Oragne Tux
	7:[Color(0.394531, 0.339749, 0.254288),Color(0.894531, 0.882984, 0.863083)],#Brown Tux
	8:[Color(0.300781, 0.291676, 0.281982),Color(0.894531, 0.882984, 0.863083)],#Brown Tux
	9:[Color(0.300781, 0.291676, 0.281982),Color(0.894531, 0.882984, 0.863083)],#Grey Tux
}

export var IsHat = false

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
	if IsHat == false:
		var CatBody = CatBodies[RandomNum("int",0,len(CatBodies)-1)]
		CatBody.visible = true#pick a cat mesh to show
		var NewMat = CatBody.get_surface_material(0).duplicate()
		var BodyColor = CatColors[RandomNum("int",0,len(CatColors)-1)]
		NewMat.set_shader_param("ColorBody",BodyColor[0])
		NewMat.set_shader_param("ColorBody2",BodyColor[1])
		CatBody.set_surface_material(0,NewMat)


func _process(_delta):
	if Input.is_action_just_pressed("Test_Store_Generate"):
		if Blasted == 0:
			BlastOff()
			Blasted = 1
