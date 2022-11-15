extends CharacterBody2D

var health = 500
var current_health = 500

var facing_direction = Vector2()
var movement_vector = null

# Called when the node enters the scene tree for the first time.
func _ready():
	name = str(get_multiplayer_authority())

@rpc(unreliable)
func set_player_state(authority_position, given_direction):
	global_position = authority_position
	facing_direction = given_direction

func spell_hit(damage):
	print("Ding spell hit")



