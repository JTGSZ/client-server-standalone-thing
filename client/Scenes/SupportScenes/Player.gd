extends KinematicBody2D

func _ready():
	pass 

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()
var speed = 500

func read_input():
	velocity = Vector2()
	
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
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)
		
func _physics_process(delta):
	read_input()
