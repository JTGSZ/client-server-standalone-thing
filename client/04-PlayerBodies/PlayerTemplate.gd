extends KinematicBody2D

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

#testcase for health
var health = 5000

var relative_target_direction: Vector2 = Vector2()
var speed = 200

var body_player_controlled = false

#onready vars basically get set in _ready lol
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#The Melee hitbox can be a part of ourselves I guess
#idk lol
onready var meleehitbox = $MeleeHitbox

func _ready():
	animationTree.active = true
	
func _physics_process(_delta):
	velocity = Vector2()
	
	if body_player_controlled:
		read_movement_inputs()

	velocity = velocity.normalized()
	
	if velocity != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)
		animationTree.set("parameters/Attack/blend_position", direction)
		animationState.travel("Run")
	else:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationState.travel("Idle")
	
	if body_player_controlled:
		read_attack_inputs()

	velocity = self.move_and_slide(velocity * self.speed)

func read_movement_inputs():
	# If we hit ctrl, we just swap directions.
	#Even if something is targeted you can force a direction change, and let go to snap back.
	#Something to consider is if we also add the velocities here, so u can strafe etc.
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
		
		if ActorController.currently_selected:
			var target_pos = ActorController.currently_selected.get_global_position()
			var our_pos = get_global_position()
			
			direction = our_pos.direction_to(target_pos)

func read_attack_inputs():
	if Input.is_action_just_pressed("spacebar"):
		animationState.travel("Attack")
		meleehitbox.position.x += direction.x * 16
		meleehitbox.position.y += direction.y * 16
		meleehitbox.position.x = 0
		meleehitbox.position.y = 0
		

#dumb selection circle lol
#when called we just make it visible and not visible ya
func selected(selected):
	var select_sprite: Sprite = get_node("Selected")
	if select_sprite:
		if selected:
			select_sprite.visible = true
		else:
			select_sprite.visible = false

#this is a signal sent to us from the hurtbox
#When a area on the hitbox layer enters it, and it is not our own.
func _on_Hurtbox_area_entered(area):
	if area.owner != self:
		print("ouch bro!")
