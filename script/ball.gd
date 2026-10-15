extends CharacterBody2D

@onready var ball_touch: AudioStreamPlayer2D = $BallTouch
@onready var color_rect: ColorRect = $ColorRect

var speed = 400
var direction = Vector2(-1, -1).normalized()
var active: bool = false

func _physics_process(delta: float) -> void:
	if active == false:
		return
	
	velocity = speed * direction
	move_and_slide()
	
	if get_last_slide_collision() != null:
		var normal = get_last_slide_collision().get_normal()
		direction = direction.bounce(normal)
		ball_touch.play()
		bounce_feedback()
		
		var obj = get_last_slide_collision().get_collider()
		if obj.has_method("bounce_feedback"):
			obj.bounce_feedback()





func reset() -> void:
	global_position = Vector2(558, 311)
	speed = 0
	await get_tree().create_timer(0.6).timeout
	if active == false:
		return
	speed = 400
	
	
func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2.ONE * 1.5)
	

func _on_main_game_waited() -> void:
	active = false
	speed = 0


func _on_main_game_started() -> void:
	active = true
	speed = 400
