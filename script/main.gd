extends Node2D

var score: int = 0
var bot_score: int = 0
var max_score: int = 3

@onready var score_label: RichTextLabel = $HUD/ScoreLabel
@onready var countdown_label: RichTextLabel = $HUD/CountdownLabel
@onready var fail_sound: AudioStreamPlayer2D = $FailSound
@onready var point_sound: AudioStreamPlayer2D = $PointSound
@onready var countdown_numbers: AudioStreamPlayer2D = $CountdownNumbers
@onready var countdown_final: AudioStreamPlayer2D = $CountdownFinal
@onready var score_particles_left: GPUParticles2D = %ScoreParticlesLeft
@onready var score_particles_right: GPUParticles2D = %ScoreParticlesRight
@onready var camera: Camera2D = $Camera2D
@onready var game_over_panel: PanelContainer = %GameOverPanel
@onready var game_over_text: RichTextLabel = %GameOverText

signal game_waited
signal game_started

func _ready() -> void:
	game_over_panel.hide()
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
	score_particles_left.emitting = true
	goal_feedback(-40)


func _on_goal_right_body_entered(body: Node2D) -> void:
	score += 1
	body.reset()
	update_score()
	point_sound.play()
	score_particles_right.emitting = true
	goal_feedback(40)
	

func update_score() -> void:
	score_label.text = str(score, " / ", bot_score)
	if score >= max_score or bot_score >= max_score:
		game_over()
	
	
func goal_feedback(abc) -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(camera, "offset:x", 0, 0.6).from(abc)


func game_over() -> void:
	var winner: int = 0
	if score > bot_score:
		winner = 1
	else:
		winner = 2
	
	game_over_panel.show()
	game_over_text.text = "Jogador %s venceu!\n" % winner
	game_over_text.text += str(score, " / ", bot_score)
	game_waited.emit()
