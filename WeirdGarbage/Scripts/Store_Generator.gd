extends Spatial

#Store Chunk segments
var Chunk_Center_0 = preload("res://Scenes/Store/StoreChunk_Center_0.tscn")
var Chunk_Corner_BL_0 = preload("res://Scenes/Store/StoreChunk_Corner_BL.tscn")
var Chunk_Corner_BR_0 = preload("res://Scenes/Store/StoreChunk_Corner_BR.tscn")
var Chunk_Corner_TL_0 = preload("res://Scenes/Store/StoreChunk_Corner_TL.tscn")
var Chunk_Corner_TR_0 = preload("res://Scenes/Store/StoreChunk_Corner_TR.tscn")
var Chunk_Wall_B_0 = preload("res://Scenes/Store/StoreChunk_Wall_B.tscn")
var Chunk_Wall_L_0 = preload("res://Scenes/Store/StoreChunk_Wall_L.tscn")
var Chunk_Wall_R_0 = preload("res://Scenes/Store/StoreChunk_Wall_R.tscn")
var Chunk_Wall_T_0 = preload("res://Scenes/Store/StoreChunk_Wall_T.tscn")

var Chunk_Directory = {
	"Center":[Chunk_Center_0],
	"Corner_BL":[Chunk_Corner_BL_0],
	"Corner_BR":[Chunk_Corner_BR_0],
	"Corner_TL":[Chunk_Corner_TL_0],
	"Corner_TR":[Chunk_Corner_TR_0],
	"Wall_B":[Chunk_Wall_B_0],
	"Wall_L":[Chunk_Wall_L_0],
	"Wall_R":[Chunk_Wall_R_0],
	"Wall_T":[Chunk_Wall_T_0]
}

onready var Chunk_Holder = get_node("LayoutHolder")

const Store_Size_Min = 3#DO NOT CHANGE THIS should be 3 always
var Store_Size_X_Max = 5#Max horizontal size of the Store
var Store_Size_Z_Max = 5#Max depth size of the Store
var Store_Size_X = 0
var Store_Size_Z = 0
var SecurityCameraPos = Vector3(0,0,0)


func RandomNum(type,range1,range2):#Creates Random Numbers
	var Output
	var Generator = RandomNumberGenerator.new()
	Generator.randomize()
	if type == "float":
		Output = Generator.randf_range(range1,range2)
	elif type == "int":
		Output = Generator.randi_range(range1,range2)
	return Output


func CreateChunk(ChunkParent,Xpos,Zpos,ChunkInstance,CameraMount):#Creates store chunks and places them
	var NewChunk = ChunkInstance.instance()
	ChunkParent.add_child(NewChunk)
	NewChunk.transform.origin = Vector3(Xpos,0,Zpos)*2.0
	if CameraMount == 1:
		SecurityCameraPos = NewChunk.get_child(3).global_transform.origin


func GenerateStore(StoreHolder):#Generates a store with double for loops yo
	var CamMount = 0
	StoreHolder.transform.origin.x = -(Store_Size_X-1)
	StoreHolder.transform.origin.z = -(Store_Size_Z-1)
	for x in range(0,max(Store_Size_X,Store_Size_Min)):
		for z in range(0,max(Store_Size_Z,Store_Size_Min)):
			var ChunkToCreate = Chunk_Directory["Center"][0]
			if x == 0:
				if z == 0:
					ChunkToCreate = Chunk_Directory["Corner_TL"][RandomNum("int",0,len(Chunk_Directory["Corner_TL"])-1)]
				elif z == Store_Size_Z-1:
					ChunkToCreate = Chunk_Directory["Corner_BL"][RandomNum("int",0,len(Chunk_Directory["Corner_BL"])-1)]
				else:
					ChunkToCreate = Chunk_Directory["Wall_L"][RandomNum("int",0,len(Chunk_Directory["Wall_L"])-1)]
			elif x == Store_Size_X-1:
				if z == 0:
					ChunkToCreate = Chunk_Directory["Corner_TR"][RandomNum("int",0,len(Chunk_Directory["Corner_TR"])-1)]
				elif z == Store_Size_Z-1:
					ChunkToCreate = Chunk_Directory["Corner_BR"][RandomNum("int",0,len(Chunk_Directory["Corner_BR"])-1)]
					CamMount = 1
				else:
					ChunkToCreate = Chunk_Directory["Wall_R"][RandomNum("int",0,len(Chunk_Directory["Wall_R"])-1)]
			else:
				if z == 0:
					ChunkToCreate = Chunk_Directory["Wall_T"][RandomNum("int",0,len(Chunk_Directory["Wall_T"])-1)]
				elif z == Store_Size_Z-1:
					ChunkToCreate = Chunk_Directory["Wall_B"][RandomNum("int",0,len(Chunk_Directory["Wall_B"])-1)]
				else:
					ChunkToCreate = Chunk_Directory["Center"][RandomNum("int",0,len(Chunk_Directory["Center"])-1)]
			CreateChunk(StoreHolder,x,z,ChunkToCreate,CamMount)
			CamMount = 0
	self.get_node("SecurityCamera").global_transform.origin = SecurityCameraPos


func _ready():
	if Chunk_Holder.get_child_count() > 0:
		for child in Chunk_Holder.get_children():
			child.queue_free()
	Store_Size_X = RandomNum("int",Store_Size_Min,Store_Size_X_Max)
	Store_Size_Z = RandomNum("int",Store_Size_Min,Store_Size_Z_Max)
	GenerateStore(Chunk_Holder)#Create the store!


func _process(_delta):
	if Input.is_action_just_pressed("Test_Store_Generate"):
		print("Regenerating Store...")
		if Chunk_Holder.get_child_count() > 0:
			for child in Chunk_Holder.get_children():
				child.queue_free()
		Store_Size_X = RandomNum("int",Store_Size_Min,Store_Size_X_Max)
		Store_Size_Z = RandomNum("int",Store_Size_Min,Store_Size_Z_Max)
		GenerateStore(Chunk_Holder)#Create the store!
