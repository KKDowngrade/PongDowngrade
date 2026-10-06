extends CharacterBody2D


var speed = 400


func _physics_process(delta: float) -> void:
	var v_direction: float = Input.get_axis("p1_move_up", "p1_move_down")
	velocity.y = v_direction * speed
	move_and_slide()
