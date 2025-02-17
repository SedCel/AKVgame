extends Node2D
@export var scene : String



func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	var scene = load("res://Scenes/" + scene + ".tscn")
	get_tree().change_scene_to_packed(scene)
