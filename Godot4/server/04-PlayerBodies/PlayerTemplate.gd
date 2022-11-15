extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	name = str(get_multiplayer_authority())

@rpc(unreliable)
func remote_set_position(authority_position):
	pass
	
