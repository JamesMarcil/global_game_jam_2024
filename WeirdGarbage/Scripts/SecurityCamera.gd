extends Camera


onready var CameraFake = get_node("../Camera_Fake")
onready var CatHumon = get_node("../../Spatial/KinematicBody/CatHuman_Skeleton/Human_Bomes/Skeleton/Spine2")

export(bool) var Tracking = true

const Fov_Blend = 0.1
var Fov_Target = 30
var Distance_ToCatHumon = 0.0
var Distance_Max = 10.0
const Tracking_Speed = 0.1
var Fov_Far = 5
var Fov_Close = 70


func _physics_process(delta):
	if Tracking == true:
		CameraFake.look_at(CatHumon.global_transform.origin,Vector3(0,1,0))
		var thisRotation = Quat(self.transform.basis).slerp(Quat(CameraFake.global_transform.basis),Tracking_Speed)
		self.set_transform(Transform(thisRotation,self.transform.origin))
		
		Distance_ToCatHumon = max(min(self.global_transform.origin.distance_to(CatHumon.global_transform.origin),Distance_Max),0.0)/Distance_Max
		Fov_Target = lerp(Fov_Close,Fov_Far,Distance_ToCatHumon)
		self.fov = lerp(self.fov,Fov_Target,Fov_Blend*(delta*60.0))
