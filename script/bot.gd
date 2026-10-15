extends CharacterBody2D

@export var speed: float = 258
@onready var color_rect: ColorRect = $ColorRect
@onready var ball: CharacterBody2D = $"../Ball"

var direction_y: float = 0
var is_multiplayer: bool = GameManager.is_multiplayer
var is_game_started: bool = false


func _ready() -> void:
	if is_multiplayer == false:
		speed = 258
	else:
		speed = 400

func _physics_process(delta: float) -> void:
	if is_multiplayer == false:
		direction_y= sign(ball.global_position.y - global_position.y)
		velocity.y = direction_y * speed
		move_and_slide()
	else:
		if is_game_started == false:
			return
		
		var v_direction: float = Input.get_axis("p2_move_up", "p2_move_down")
		velocity.y = v_direction * speed
		move_and_slide()


func _on_main_game_started() -> void:
	is_game_started = true


func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2(1.2, 2.0))
	
