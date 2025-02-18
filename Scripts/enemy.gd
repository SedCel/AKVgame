extends Area2D

@export var mini_game_scene: PackedScene
@onready var player = $"../player"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body):
	if body.name == "player":
		show_minigame()
		

func damageIflost():
	player.taken_damage(1)

func show_minigame():
	var minigame = mini_game_scene.instantiate()
	var parent = get_parent()
	var canvas = parent.get_node("CanvasLayer")
	canvas.add_child(minigame)
	var viewport_rect = get_viewport().get_visible_rect()
	minigame.position = viewport_rect.size / 2.6
	minigame.connect("lose_mg", Callable(self, "damageIflost"))
