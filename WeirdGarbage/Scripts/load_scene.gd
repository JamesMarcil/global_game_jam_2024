class_name LoadScene extends Node

export(String, FILE) var sceneToLoad:String

func loadExportedScene() -> void:
	get_tree().change_scene(sceneToLoad)
