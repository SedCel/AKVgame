extends Node

@export var light : PointLight2D
@export var light_energyMAX: float
@export var wait_second: float
@export var morganie : bool


func _ready() -> void:
	$PointLight2D/AnimationPlayer.play("new_animation")
	
	


func morganie_light():
	while morganie == true:
		light.energy = 0.3
		light.energy = light_energyMAX
		await wait_seconds(wait_second)



func wait_seconds(seconds: float) -> void:
	var timer = Timer.new()  
	add_child(timer)  
	timer.start(seconds)  
	await timer.timeout  
	timer.queue_free() 
