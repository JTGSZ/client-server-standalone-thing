extends Position2D

var current_body: KinematicBody2D
var following_mob: bool = false

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

var current_target: KinematicBody2D

func _ready():
	pass

func _physics_process(_delta):
	follow_controlled_mob()
#	read_input()
		
func follow_controlled_mob():
	if current_body && following_mob:
		self.position = current_body.position

#func read_input():
	#velocity = Vector2()

	#if Input.is_action_pressed("Up"):
	#	velocity.y -= 1
		#direction = Vector2(0, -1)
	#if Input.is_action_pressed("Down"):
	#	velocity.y += 1
		#direction = Vector2(0, 1)
	#if Input.is_action_pressed("Left"):
	#	velocity.x -= 1
		#direction = Vector2(-1, 0)
	#if Input.is_action_pressed("Right"):
	#	velocity.x += 1
		#direction = Vector2(1, 0)
	
	#if self.current_body:
	#	velocity = velocity.normalized()
	#	velocity = current_body.move_and_slide(velocity * current_body.speed)

func _input(event):
	#tab mob control swaps
	if(Input.is_action_just_released("tab")):
		swap_to_next_mob()
	
	if(Input.is_action_just_pressed("left_mousebutton")):
		print(event)

#------------------------
#		HELPERS
#------------------------
#We take control of a mob
func take_control_of_mob():
	if ActorController.controllable_characters.size() != 0:
		if current_body:
			current_body.body_player_controlled = false
			following_mob = false
			current_body = null
		else:
			following_mob = true
			current_body = ActorController.controllable_characters[0]
			current_body.body_player_controlled = true
	else:
		print("No mobs to control")

#We swap to next mob in the array of shit we can control
func swap_to_next_mob():
	if(!current_body):
		take_control_of_mob()
	else:
		current_body.body_player_controlled = false
		var curmob_index = ActorController.controllable_characters.find(current_body)
		var curmob_size = ActorController.controllable_characters.size()
		var curmob_next_val = 0
		
		if curmob_index > -1:
			curmob_next_val = curmob_index+1
			if curmob_next_val > curmob_size-1:
				curmob_next_val = 0
			current_body = ActorController.controllable_characters[curmob_next_val]
			current_body.body_player_controlled = true

