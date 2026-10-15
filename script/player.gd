extends CharacterBody2D

@onready var color_rect: ColorRect = $ColorRect


var speed = 400
var is_game_started:bool = false




func _physics_process(delta: float) -> void:
	if is_game_started == false:
		return
		
	var v_direction: float = Input.get_axis("p1_move_up", "p1_move_down")
	velocity.y = v_direction * speed
	move_and_slide()


func _on_main_game_started() -> void:
	is_game_started = true
	
	
func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2(1.2, 2.0))
	
