extends CharacterBody2D


const SPEED = 300.0

func _enter_tree():
	set_multiplayer_authority(int(str(name)))

func _ready():
	if !is_multiplayer_authority():
		$Sprite2D.modulate = Color.RED

func _physics_process(delta):
	if !is_multiplayer_authority():
		return
	var horizontal_dir = Input.get_axis("ui_left", "ui_right")
	var vertical_dir = Input.get_axis("ui_up", "ui_down")
	if horizontal_dir:
		velocity.x = horizontal_dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical_dir:
		velocity.y = vertical_dir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
