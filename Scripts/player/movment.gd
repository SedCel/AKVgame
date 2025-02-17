extends CharacterBody2D

@export var speed = 80
@onready var animations = $AnimationPlayer
@onready var previousDirection: String = "down"
@onready var actionable_finder: Area2D = $direction/ActionableFinder
@onready var healthBar = $"../CanvasLayer/AnimationHP"
var max_hp = 3
var current_hp = max_hp


func _update():
	current_hp
	healthBar

func _ready():
	pass
	

func update_Animation_HP():
	if current_hp == 3:
		healthBar.play("fullHP")
	elif current_hp == 2:
		healthBar.play("lowHp")
	elif current_hp == 1:
		healthBar.play("oneHP")



func handleInput():
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * speed
	
func updateAnimation():
	var direction = "down"
	if velocity.x < 0: direction = "left"
	elif velocity.x > 0: direction = "right"
	elif velocity.y < 0: direction = "up"
	elif velocity.y > 0: direction = "down"
	if velocity.length() == 0:
		animations.play("idle_" + previousDirection)
	else:
		animations.play("walk_" + direction)
		previousDirection = direction
		


func heal(amount):
	current_hp += amount
	if current_hp > max_hp:
		current_hp = max_hp
	update_Animation_HP()

func taken_damage(amount):
	current_hp -= amount
	update_Animation_HP()
	if current_hp <= 0:
		death()
	

func death():
	queue_free()


func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	


func _on__hp_pressed() -> void:
	taken_damage(1)


func _on__hpplus_pressed() -> void:
	heal(1)
