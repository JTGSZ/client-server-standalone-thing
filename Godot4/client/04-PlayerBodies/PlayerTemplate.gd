extends CharacterBody2D

class_name PlayerTemplate

#the direction we are moving
#var velocity: Vector2 = Vector2()
#the direction we are facing.
var facing_direction: Vector2 = Vector2(-1, 0)

#testcase for health
var max_health = 500
var current_health = 500
#How fast we goin atm
var speed = 200
#Do we have a player hooked into us?
var body_player_controlled = false

#Test-----------------------------------------

#Test-----------------------------------------
#floating text effect for damage/heals or some shit.
var floating_text = preload("res://06-Unsorted/FloatingText.tscn")


#Character States
enum {
	NORMAL, #Business as usual
	STUNNED #Stops the body from accepting any inputs
}
var character_state = NORMAL

#Do we stop movement input?
var stop_movement_input = false

#selected circle sprite
@onready var select_sprite:Sprite2D = $Selected
#Ability Holder
@onready var AbilityHolder = $AbilityHolder

#onready vars basically get set in _ready lol
#this is just animation player and state shit
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

#The Melee hitbox can be a part of ourselves I guess
#idk lol


func _ready():
	name = str(get_multiplayer_authority())
	animationTree.active = true
	AbilityHolder.parent_body = self
	
func _physics_process(_delta):
	velocity = Vector2()
	
	#If we r controlled, not currently dashing, and our character state is normal
#	if body_player_controlled && !stop_movement_input && character_state == NORMAL:
	if is_multiplayer_authority():
		read_movement_inputs()

	movement_animations()

	if body_player_controlled && character_state != STUNNED:
		read_attack_inputs()
		pass
	
	#This basically makes sure our diagonals don't go xtra fast
#	velocity = velocity.normalized()
	set_velocity(velocity * speed)
	move_and_slide()
	if is_multiplayer_authority():
		rpc("set_player_state", global_position)

func movement_animations():
	#Animation shit lol
	if velocity != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", facing_direction)
		animationTree.set("parameters/Run/blend_position", facing_direction)
		animationState.travel("Run")
	else:
		animationTree.set("parameters/Idle/blend_position", facing_direction)
		animationState.travel("Idle")
	animationTree.set("parameters/Attack/blend_position", facing_direction)

func read_movement_inputs():
	if ActorController.inputs_enabled:
		
		# If we hit ctrl, we just swap directions.
		#Even if something is targeted you can force a direction change, and let go to snap back.
		#Something to consider is if we also add the velocities here, so u can strafe etc.
		if Input.is_action_pressed("ctrl"):
			if Input.is_action_just_pressed("Up"):
				facing_direction = Vector2(0, -1)
			if Input.is_action_just_pressed("Down"):
				facing_direction = Vector2(0, 1)
			if Input.is_action_just_pressed("Left"):
				facing_direction = Vector2(-1, 0)
			if Input.is_action_just_pressed("Right"):
				facing_direction = Vector2(1, 0)
		else:
			if Input.is_action_pressed("Up"):
				velocity.y -= 1
				facing_direction = Vector2(0, -1)
			if Input.is_action_pressed("Down"):
				velocity.y += 1
				facing_direction = Vector2(0, 1)
			if Input.is_action_pressed("Left"):
				velocity.x -= 1
				facing_direction = Vector2(-1, 0)
			if Input.is_action_pressed("Right"):
				velocity.x += 1
				facing_direction = Vector2(1, 0)

			if ActorController.currently_selected:
				var target_pos = ActorController.currently_selected.get_global_position()
				var our_pos = get_global_position()
				
				facing_direction = our_pos.direction_to(target_pos)
				

#Read attack input lol
func read_attack_inputs():
	if ActorController.inputs_enabled:
		if Input.is_action_just_pressed("spacebar"):
			AbilityHolder.fire_bindkey("spacebar")
			
		if Input.is_action_just_pressed("one_key"):
			AbilityHolder.fire_bindkey("one")
			
		if Input.is_action_just_pressed("two_key"):
			AbilityHolder.fire_bindkey("two")

#dumb selection circle lol
#when called we just make it visible and not visible ya
func selected(sprite_selected):

	if select_sprite:
		if sprite_selected:
			select_sprite.visible = true
		else:
			select_sprite.visible = false

#we received actual damage
func receive_damage(dmg_amount):
	var dmg_text = floating_text.instantiate()
	dmg_text.position = get_global_position()
	dmg_text.amount = dmg_amount
	get_parent().add_child(dmg_text)
	
	current_health -= dmg_amount
	update_healthbar()
	
	print("Taken Attack:", current_health, "/500")
	
#Hit by a spell?
func spell_hit(attack):
	receive_damage(attack)

func update_healthbar():
	ActorController.player_controller.update_healthbar(self)
	
@rpc(unreliable)
func set_player_state(authority_position):
	global_position = authority_position
