extends Node2D

@onready var duration_timer:Timer = $DurationTimer
var attached_body:CharacterBody2D

func attach_to_body(given_body):
	attached_body = given_body
	
func detach_from_body():
	attached_body = null

func start_dash(duration):
	duration_timer.wait_time = duration
	attached_body.speed += 200
	duration_timer.start()

func is_dashing():
	return !duration_timer.is_stopped()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_duration_timer_timeout():
	pass # Replace with function body.
