extends CharacterBody2D

@export var speed: float = 258

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
