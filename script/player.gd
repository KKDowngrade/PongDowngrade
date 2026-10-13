extends CharacterBody2D


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
