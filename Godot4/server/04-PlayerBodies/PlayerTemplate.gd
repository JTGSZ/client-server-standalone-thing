extends CharacterBody2D

var health = 500
var current_health = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	name = str(get_multiplayer_authority())

@rpc(unreliable)
func set_player_state(authority_position):
	global_position = authority_position

#lol
@rpc
func test_case_1(test_info):
	print("We hit")

