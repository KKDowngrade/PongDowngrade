extends Node2D

var score: int = 0
var bot_score: int = 0
@onready var score_label: RichTextLabel = $HUD/ScoreLabel
@onready var countdown_label: RichTextLabel = $HUD/CountdownLabel

signal game_waited
signal game_started

func _ready() -> void:
	game_waited.emit()
	update_score()
	countdown_label.text = str("[color=red]3")
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=yellow]2")
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=green]1")
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[rainbow][wave]Vai!")
	await  get_tree().create_timer(0.6).timeout
	countdown_label.hide()
	game_started.emit()



func _on_goal_left_body_entered(body: Node2D) -> void:
	bot_score += 1
	body.reset()
	update_score()


func _on_goal_right_body_entered(body: Node2D) -> void:
	score += 1
	body.reset()
	update_score()

func update_score() -> void:
	score_label.text = str(score, " / ", bot_score)
	
