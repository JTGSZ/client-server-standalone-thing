extends Node2D

var projectile = preload("res://08-Projectiles/Ice_Spear.tscn")

var linked_body:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
@rpc
func fire_ability_on_server(given_rotation, peer_id):
	var spell_instance = projectile.instantiate()
	get_parent().get_parent().get_parent().add_child(spell_instance)
	spell_instance.origin_caster = linked_body

#	spell_instance.position = linked_body.get_global_position()
	spell_instance.position = linked_body.get_global_position()
	spell_instance.rotation = given_rotation
	
	rpc("fire_ability_on_clients", given_rotation, peer_id)
	
@rpc
func fire_ability_on_clients():
	pass

