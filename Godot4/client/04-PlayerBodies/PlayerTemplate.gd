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
#Spells
var spell = preload("res://99-TestCases/Spell.tscn")
var can_fire = true
var rate_of_fire = 0.4
#Test-----------------------------------------
#floating text effect for damage/heals or some shit.
var floating_text = preload("res://06-Unsorted/FloatingText.tscn")
#are we currently dashing?
var currently_dashing = false
var dash_vector: Vector2 = Vector2()
var dash_ticks_left = 0

var dash_ticks = 25
var dash_speed = 150

#Character States
enum {
	NORMAL, #Business as usual
	STUNNED #Stops the body from accepting any inputs
}
var character_state = NORMAL

var dash_duration = 0.2

#selected circle sprite
@onready var select_sprite:Sprite2D = $Selected

#onready vars basically get set in _ready lol
#this is just animation player and state shit
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

#The Melee hitbox can be a part of ourselves I guess
#idk lol


func _ready():
	animationTree.active = true
	
func _physics_process(_delta):
	velocity = Vector2()
	
	#If we r controlled, not currently dashing, and our character state is normal
	if body_player_controlled && !currently_dashing && character_state == NORMAL:
		read_movement_inputs()

	#If currently dashing set our velocity to the dash vector
	if currently_dashing:
		velocity = dash_vector
		dash_ticks_left -= 1
		if dash_ticks_left <= 0:
			currently_dashing = false
			speed -= dash_speed
		
	#Animation shit lol
	if velocity != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", facing_direction)
		animationTree.set("parameters/Run/blend_position", facing_direction)
		animationState.travel("Run")
	else:
		animationTree.set("parameters/Idle/blend_position", facing_direction)
		animationState.travel("Idle")
	animationTree.set("parameters/Attack/blend_position", facing_direction)
	
	if body_player_controlled && character_state != STUNNED:
#		read_attack_inputs()
		pass
	
	#This basically makes sure our diagonals don't go xtra fast
#	velocity = velocity.normalized()
	set_velocity(velocity * speed)
	move_and_slide()

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
				
		if Input.is_action_just_pressed("spacebar"):
			if velocity:
				dash_vector = velocity
			else:
				dash_vector = facing_direction
				
			currently_dashing = true
			dash_ticks_left = dash_ticks
			speed += dash_speed


#Read attack input lol
func read_attack_inputs():
	if ActorController.inputs_enabled:
		if Input.is_action_just_pressed("spacebar") and can_fire == true:
			can_fire = false
			animationState.travel("Attack")
			var spell_instance = spell.instantiate()
			get_parent().add_child(spell_instance)
			spell_instance.origin_caster = self
			#origin position
			spell_instance.position = get_global_position()
			
			spell_instance.rotation = get_angle_to(get_global_mouse_position())
			
			await get_tree().create_timer(rate_of_fire).timeout
			
			can_fire = true

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
	
	print("Taken Attack:", current_health, "/5000")
	
#Hit by a spell?
func spell_hit(attack):
	receive_damage(attack)

func update_healthbar():
	ActorController.player_controller.update_healthbar(self)
	
