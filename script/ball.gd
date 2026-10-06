extends CharacterBody2D

var speed = 400
var direction = Vector2(-1, -1).normalized()

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()
	
	if get_last_slide_collision() != null:
		var normal = get_last_slide_collision().get_normal()
		direction = direction.bounce(normal)
