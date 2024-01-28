extends Spatial


onready var Shelf_Holder = get_node("ShelfMarker")
onready var Shelf_00 = preload("res://Scenes/Store/Shelf_00.tscn")
onready var Shelf_01 = preload("res://Scenes/Store/Shelf_01.tscn")
onready var Shelf_02 = preload("res://Scenes/Store/Shelf_02.tscn")

onready var Shelf_Database = {
	0:Shelf_00,
	1:Shelf_01,
	#2:Shelf_02,
}
var Shelf_Chance = 0.75
var Shelf_RotationRange = 0.5


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
	if RandomNum("float",0.0,1.0) < Shelf_Chance:
		var NewShelf = Shelf_Database[RandomNum("int",0,len(Shelf_Database)-1)].instance()
		Shelf_Holder.add_child(NewShelf)
		var ShelfRotation = NewShelf.transform.basis.rotated(Vector3(0,1,0),RandomNum("float",-Shelf_RotationRange,Shelf_RotationRange))
		NewShelf.transform.basis = ShelfRotation
