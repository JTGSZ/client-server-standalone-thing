extends Node

var ice_spear = preload("res://07-Abilities/04-Icicle Spear/Icicle_Spear.tscn")
# Called when the node enters the scene tree for the first time.

var ability_dict = {}

func _ready():
	var fuck = ice_spear.instantiate()
	add_child(fuck)
	add_ability("icicle_spear", fuck)

#These need to re redone, cause idk what i was thinkin there
#Adds an ability to the dictionary of this thing.
func add_ability(given_key, object):
	ability_dict[given_key] = object
	object.linked_body = get_parent()
	object.set_multiplayer_authority(get_multiplayer_authority())

#Removes an ability from the dictionary of this thing.
func remove_ability(given_key):
	ability_dict.erase(given_key)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#@rpc
#func test_func_1():
#	print("We got through")
#	print(get_multiplayer_authority())
