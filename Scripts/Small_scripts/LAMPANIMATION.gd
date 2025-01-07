extends Node

@export var animation: String
@export var light: PointLight2D
@export var animator: AnimationPlayer

func _ready() -> void:
	animator.play(animation)
