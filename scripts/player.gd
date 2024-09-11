extends CharacterBody2D


@export var speed = 200
@export var gravity = 30
@export var jump_force = 3000




@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func  _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction !=0:
		switch_direction(horizontal_direction)
		
	move_and_slide()
	
	update_animations(horizontal_direction)
	print("Velocity: " + str(velocity))
	print("Horizontal direction: " + str(horizontal_direction))

func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("walk")
	else:
		if horizontal_direction == 0:
			if velocity.y < 0:
				ap.play("jump_default")
			else:
				ap.play("fall_default")
		else:
			if velocity.y < 0:
				ap.play("jump_side")
			else:
				ap.play("fall_side")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	if horizontal_direction > 0:
		sprite.position.x = horizontal_direction + -1
	else:
		sprite.position.x = horizontal_direction + 2



	
