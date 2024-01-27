class_name PlayButton extends Button

export(String, FILE) var sceneToLoad:String

func _pressed():
	get_tree().change_scene(sceneToLoad)
