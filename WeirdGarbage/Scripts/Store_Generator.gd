extends Spatial

#Store Chunk segments
var Chunk_Center_0 = preload("res://Scenes/Store/StoreChunk_Center_0.tscn")
var Chunk_Corner_BL = preload("res://Scenes/Store/StoreChunk_Corner_BL.tscn")
var Chunk_Corner_BR = preload("res://Scenes/Store/StoreChunk_Corner_BR.tscn")
var Chunk_Corner_TL = preload("res://Scenes/Store/StoreChunk_Corner_TL.tscn")
var Chunk_Corner_TR = preload("res://Scenes/Store/StoreChunk_Corner_TR.tscn")
var Chunk_Wall_B = preload("res://Scenes/Store/StoreChunk_Wall_B.tscn")
var Chunk_Wall_L = preload("res://Scenes/Store/StoreChunk_Wall_L.tscn")
var Chunk_Wall_R = preload("res://Scenes/Store/StoreChunk_Wall_R.tscn")
var Chunk_Wall_T = preload("res://Scenes/Store/StoreChunk_Wall_T.tscn")

onready var Chunk_Holder = get_node("LayoutHolder")

const Store_Size_Min = 2#DO NOT CHANGE THIS should be 2 always
var Store_Size_X_Max = 3
var Store_Size_Z_Max = 3


func RandomNum(type,range1,range2):#Creates Random Numbers
	var Output
	var Generator = RandomNumberGenerator.new()
	Generator.randomize()
	if type == "float":
		Output = Generator.randf_range(range1,range2)
	elif type == "int":
		Output = Generator.randi_range(range1,range2)
	return Output


func CreateChunk(ChunkParent,Xpos,Zpos,ChunkInstance):#Creates store chunks and places them
	var NewChunk = ChunkInstance.instance()
	ChunkParent.add_child(NewChunk)
	NewChunk.transform.origin = Vector3(Xpos,0,Zpos)*2.10


func GenerateStore(StoreHolder):#Generates a store with double for loops yo
	StoreHolder.transform.origin.x = -(Store_Size_X_Max-1)
	StoreHolder.transform.origin.z = -(Store_Size_Z_Max-1)
	for x in range(0,max(Store_Size_X_Max,Store_Size_Min)):
		for z in range(0,max(Store_Size_Z_Max,Store_Size_Min)):
			var ChunkToCreate = Chunk_Center_0
			if x == 0:
				if z == 0:
					ChunkToCreate = Chunk_Corner_TL
				elif z == Store_Size_Z_Max-1:
					ChunkToCreate = Chunk_Corner_BL
				else:
					ChunkToCreate = Chunk_Wall_L
			elif x == Store_Size_X_Max-1:
				if z == 0:
					ChunkToCreate = Chunk_Corner_TR
				elif z == Store_Size_Z_Max-1:
					ChunkToCreate = Chunk_Corner_BR
				else:
					ChunkToCreate = Chunk_Wall_R
			else:
				if z == 0:
					ChunkToCreate = Chunk_Wall_T
				elif z == Store_Size_Z_Max-1:
					ChunkToCreate = Chunk_Wall_B
				else:
					ChunkToCreate = Chunk_Center_0
			CreateChunk(StoreHolder,x,z,ChunkToCreate)


func _ready():
	GenerateStore(Chunk_Holder)#Create the store!
