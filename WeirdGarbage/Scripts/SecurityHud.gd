extends Node2D

onready var RecordMarker = get_node("RecordMarker")
onready var TimeStamp = get_node("TimeStamp")
var MiliSeconds = 0.0

func _physics_process(delta):
	var CurrentTime = OS.get_time()
	if MiliSeconds < 60:
		MiliSeconds += delta*60.0
	else:
		MiliSeconds = 0.0
		if RecordMarker.visible == false:
			RecordMarker.visible = true
		else:
			RecordMarker.visible = false
	TimeStamp.text = str(CurrentTime["hour"])+":"+str(CurrentTime["minute"])+":"+str(CurrentTime["second"])+":"+str(int(MiliSeconds))
