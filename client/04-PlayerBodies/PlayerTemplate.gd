extends KinematicBody2D

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()
var speed = 200

var body_player_controlled = false

onready var animationPlayer = $AnimationPlayer

var animationState = "IdleRight"

func move_this_body(velocity, direction):
	self.move_and_slide(velocity * speed)
	
func _physics_process(_delta):
	velocity = Vector2()
	
	if body_player_controlled:
		read_inputs()
		
	update_sprite()

	velocity = velocity.normalized()
	velocity = self.move_and_slide(velocity * self.speed)

func update_sprite():
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			animationPlayer.play("RunRight")
		elif velocity.x < 0:
			animationPlayer.play("RunLeft")
		elif velocity.y > 0:
			animationPlayer.play("RunDown")
		else:
			animationPlayer.play("RunUp")
	else:
		if direction.y < 0:
			animationPlayer.play("IdleUp")
		elif direction.y > 0:
			animationPlayer.play("IdleDown")
		elif direction.x < 0:
			animationPlayer.play("IdleLeft")
		else:
			animationPlayer.play("IdleRight")	

func read_inputs():
	if Input.is_action_pressed("ctrl"):
		if Input.is_action_just_pressed("Up"):
			direction = Vector2(0, -1)
		if Input.is_action_just_pressed("Down"):
			direction = Vector2(0, 1)
		if Input.is_action_just_pressed("Left"):
			direction = Vector2(-1, 0)
		if Input.is_action_just_pressed("Right"):
			direction = Vector2(1, 0)
	else:
		if Input.is_action_pressed("Up"):
			velocity.y -= 1
			direction = Vector2(0, -1)
		if Input.is_action_pressed("Down"):
			velocity.y += 1
			direction = Vector2(0, 1)
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
			direction = Vector2(-1, 0)
		if Input.is_action_pressed("Right"):
			velocity.x += 1
			direction = Vector2(1, 0)
		
#dumb selection circle lol
func selected(selected):
	var select_sprite: Sprite = get_node("Selected")
	if select_sprite:
		if selected:
			select_sprite.visible = true
		else:
			select_sprite.visible = false
		
