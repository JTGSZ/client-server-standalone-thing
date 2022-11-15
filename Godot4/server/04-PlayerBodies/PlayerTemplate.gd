extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	name = str(get_multiplayer_authority())

@rpc(unreliable)
func set_player_state(authority_position):
	global_position = authority_position
	pass
	
