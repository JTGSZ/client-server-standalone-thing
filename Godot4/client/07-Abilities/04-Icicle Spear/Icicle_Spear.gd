extends Node2D

var projectile = preload("res://99-TestCases/Spell.tscn")

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
	
	spell_instance.position = linked_body.get_global_position()
	spell_instance.rotation = get_angle_to(get_global_mouse_position())
	
	
	
	
	
	
	
	
