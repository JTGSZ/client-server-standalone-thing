extends Node2D

var projectile = preload("res://08-Projectiles/Ice_Spear.tscn")

var linked_body:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire_ability():
	var spell_instance = projectile.instantiate()
	get_parent().get_parent().get_parent().add_child(spell_instance)
	spell_instance.origin_caster = linked_body
	
#	spell_instance.position = linked_body.get_global_position()
	spell_instance.position = linked_body.get_global_position()
	if ActorController.currently_selected && ActorController.currently_selected != linked_body:
		spell_instance.rotation = linked_body.get_angle_to(ActorController.currently_selected.global_position)
	else:
		spell_instance.rotation = linked_body.get_angle_to(get_global_mouse_position())
	

	
	
	
	
	
	
	
	
