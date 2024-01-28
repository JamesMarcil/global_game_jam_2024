extends Node2D

onready var RecordMarker = get_node("Container/RecordMarker")
onready var TimeStamp = get_node("Container/TimeStamp")
var MiliSeconds = 0.0

onready var ViewportCont = get_node("ViewportContainer")
onready var NativeResolution = OS.get_screen_size()

func ChangeResolution():
	#Zero Out RECTS so the viewport scales correctly
	ViewportCont.rect_scale = Vector2(1.0,1.0)
	ViewportCont.rect_pivot_offset = Vector2(0.0,0.0)
	ViewportCont.rect_position = Vector2(0.0,0.0)
	OS.window_fullscreen = true
	OS.window_size.x = OS.get_screen_size().x
	OS.window_size.y = OS.get_screen_size().y
	ViewportCont.margin_right = OS.get_screen_size().x
	ViewportCont.margin_bottom = OS.get_screen_size().y
	var Scaling = 1.0
	var ScreenX_Difference = ViewportCont.margin_right/OS.get_screen_size().x
	var ScreenY_Difference = ViewportCont.margin_bottom/OS.get_screen_size().y
	if ScreenX_Difference > ScreenY_Difference:
		Scaling = OS.get_screen_size().x/ViewportCont.margin_right
	else:
		Scaling = OS.get_screen_size().y/ViewportCont.margin_bottom
	ViewportCont.rect_scale = Vector2(Scaling,Scaling)
	ViewportCont.rect_pivot_offset = ViewportCont.rect_size/2.0
	ViewportCont.rect_position.x = (OS.get_screen_size().x-ViewportCont.margin_right)*0.5
	ViewportCont.rect_position.y = (OS.get_screen_size().y-ViewportCont.margin_bottom)*0.5
	
	#1024/1920
	get_node("Container").scale = Vector2(1.87,1.8)


func _ready():
	pass
	#ChangeResolution()


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
	
	
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
