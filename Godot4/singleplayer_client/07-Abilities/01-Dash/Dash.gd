extends Node2D

#A ref to our hosts body, incase we need it.
#crammed on when you use add_ability on the ability_holder
var linked_body:CharacterBody2D

#physics shit
var dash_vector: Vector2 = Vector2()
var dash_speed = 150

#duration the dash lasts
var duration = 0.5
@onready var duration_timer:Timer = $Duration

#So we don't fire dashes in dashes
var currently_dashing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func _physics_process(delta):
	linked_body.velocity = dash_vector
	linked_body.movement_animations()
	
	linked_body.set_velocity(dash_vector * linked_body.speed)
	linked_body.move_and_slide()
	
#Here is where we do the shit.
func fire_ability():
#	print(linked_body.velocity)
	if !currently_dashing:
		currently_dashing = true

		if linked_body.velocity:
			
			dash_vector = linked_body.velocity
		else:
			dash_vector = linked_body.facing_direction
			
#		print(dash_vector)
		
		linked_body.stop_movement_input = true
		linked_body.speed += dash_speed

		duration_timer.wait_time = duration
		duration_timer.start()
		
		set_physics_process(true)


func _on_duration_timeout():
	set_physics_process(false)
	linked_body.stop_movement_input = false
	linked_body.speed -= dash_speed
	dash_vector = Vector2.ZERO
	currently_dashing = false
	
	
	
	
	
	
	
	
	
	
	
	
