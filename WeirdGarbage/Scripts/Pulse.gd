extends Spatial


export var Mode_Random = 0
export var Mode_Scale = 0
export var Mode_Rotate = 0
export var Mode_Spin = 0
export var Mode_Slide = 0

var Time = 0.0
var Time_Speed = 0.1
export var Time_Mod = 0.0

var Scale = 0.0
onready var Scale_Base = scale.x
export var Scale_Range = 0.1
export var Scale_Speed = 1.0

var Rotation = 0.0
export var Rotation_Start = 0.0
export var Rotation_Range = 7.0
export var Rotation_Speed = 1.5
export var Rotation_Vector = 2

var Spin = 0.0
export var Spin_Speed = 0.0
export var Spin_Direction = 1
export var Spin_Vector = 0

var Slide = 0.0
export var Slide_Range = 0.04
export var Slide_Offset = 0.0
export var Slide_Direction = 0
export var Slide_Inverse = 1
export var Slide_Speed = 0.75

func RandomNum(type,range1,range2):#Creates Random Numbers
	var Output
	var Generator = RandomNumberGenerator.new()
	Generator.randomize()
	if type == "float":
		Output = Generator.randf_range(range1,range2)
	elif type == "int":
		Output = Generator.randi_range(range1,range2)
	return Output


func _ready():
	Time = RandomNum("float",0.0,4.74)
	
	if Mode_Random == 1:
		var Options_Num = RandomNum("int",0,1)
		if Options_Num == 0:
			Mode_Scale = 1
		else:
			Mode_Rotate = 1


func _physics_process(delta):
	Time += Time_Speed+(Time_Mod*(delta*60.0))
	
	if Mode_Scale == 1:#SCALE
		Scale = sin(Time/Scale_Speed)*Scale_Range*Scale_Base
		scale = Vector3(Scale_Base+Scale,Scale_Base+Scale,Scale_Base+Scale)
		
	if Mode_Rotate == 1:#ROTATION
		Rotation = sin(Time/Rotation_Speed)*Rotation_Range+Rotation_Start
		if Rotation_Vector == 0:#X
			rotation_degrees = Vector3(Rotation,0,0)
		elif Rotation_Vector == 1:#Y
			rotation_degrees = Vector3(0,Rotation,0)
		elif Rotation_Vector == 2:#Z
			rotation_degrees = Vector3(0,0,Rotation)
	
	if Mode_Spin == 1:#Spin
		Spin = (Spin_Speed*Spin_Direction)*Time
		if Spin_Vector == 0:#X
			rotation_degrees = Vector3(Spin,0,0)
		elif Spin_Vector == 1:#Y
			rotation_degrees = Vector3(0,Spin,0)
		elif Spin_Vector == 2:#Z
			rotation_degrees = Vector3(0,0,Spin)
	
	if Mode_Slide == 1:#SLIDE
		Slide = sin((Time*Slide_Inverse)/Slide_Speed)*Slide_Range
		if Slide_Direction == 0:#X
			transform.origin = Vector3(Slide+Slide_Offset,0,0)
		elif Slide_Direction == 1:#Y
			transform.origin = Vector3(0,Slide+Slide_Offset,0)
		elif Slide_Direction == 2:#Z
			transform.origin = Vector3(0,0,Slide+Slide_Offset)
