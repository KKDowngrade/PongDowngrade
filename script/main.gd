extends Node2D

var score: int = 0
var bot_score: int = 0
@onready var score_label: RichTextLabel = $HUD/ScoreLabel
@onready var countdown_label: RichTextLabel = $HUD/CountdownLabel
@onready var fail_sound: AudioStreamPlayer2D = $FailSound
@onready var point_sound: AudioStreamPlayer2D = $PointSound
@onready var countdown_numbers: AudioStreamPlayer2D = $CountdownNumbers
@onready var countdown_final: AudioStreamPlayer2D = $CountdownFinal

signal game_waited
signal game_started

func _ready() -> void:
	game_waited.emit()
	update_score()
	countdown_label.text = str("[color=red]3")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=yellow]2")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=green]1")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[rainbow][wave]Vai!")
	countdown_final.play()
	await  get_tree().create_timer(0.6).timeout
	countdown_label.hide()
	game_started.emit()



func _on_goal_left_body_entered(body: Node2D) -> void:
	bot_score += 1
	body.reset()
	fail_sound.play()
	update_score()


func _on_goal_right_body_entered(body: Node2D) -> void:
	score += 1
	body.reset()
	update_score()
	point_sound.play()

func update_score() -> void:
	score_label.text = str(score, " / ", bot_score)
	
