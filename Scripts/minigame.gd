extends Control

@export var timer_limit: float = 5.0
var balls_clicked: int = 0
var timerr : Timer



func _ready():
	
	timerr = $TimerMG
	timerr.timeout.connect(_lose_game)
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.pressed.connect(_on_ball_pressed.bind(child))
	
	_start_game()


func _on_ball_pressed(ball: TextureButton):
	balls_clicked += 1
	ball.queue_free()
	if balls_clicked >= 3:
		timerr.stop()
		finish_game()

func _lose_game():
	$LabelMG.text = "LOSER TRY AGAIN"
	$LabelMG.visible = true
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.visible = false
	
	
	await wait_seconds(3)
	
	_start_game()
	

func _start_game():
	balls_clicked = 0
	randomize_ball_positions()
	timerr.start(timer_limit)
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.visible = true
	

func randomize_ball_positions():
	var panel_rect = $PanelMG.get_rect()
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.position = Vector2(
			randi_range(panel_rect.position.x + 50, panel_rect.position.x + panel_rect.size.x - 50),
			randi_range(panel_rect.position.y + 50, panel_rect.position.y + panel_rect.size.y - 50)
			)


func finish_game():
	$LabelMG.text = "WIN"
	$LabelMG.visible = true
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.visible = false
	await wait_seconds(2)
	queue_free()
	

func wait_seconds(seconds: float) -> void:
	var timer = Timer.new()  
	add_child(timer)  
	timer.start(seconds)  
	await timer.timeout  
	timer.queue_free()  

func close_game():
		queue_free()
