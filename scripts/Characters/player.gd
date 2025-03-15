class_name Player
extends CharacterBody2D

@onready var character_sprite_2d = $Sprite2D
@onready var left_hand_container = $LeftHandContainer
@onready var left_hand_sprite = $LeftHandContainer/AnimatedSprite2D

const SPEED = 300.0

func _enter_tree():
	set_multiplayer_authority(int(str(name)))

func _ready():
	if !is_multiplayer_authority():
		$Sprite2D.modulate = Color("#ff00ff")

func _physics_process(delta):
	if !is_multiplayer_authority():
		return
		
	left_hand_container.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < global_position.x:
		left_hand_sprite.flip_h = true
	else:
		left_hand_sprite.flip_h = false
		
	var horizontal_dir = Input.get_axis("left", "right")
	var vertical_dir = Input.get_axis("up", "down")
	if horizontal_dir:
		velocity.x = horizontal_dir * SPEED
		flip_character()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical_dir:
		velocity.y = vertical_dir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func flip_character():
	if velocity.x > 0:
		character_sprite_2d.flip_h = true
	if velocity.x < 0:
		character_sprite_2d.flip_h = false
