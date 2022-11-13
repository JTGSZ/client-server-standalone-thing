extends Node

#Basically this is just a node that holds abilities

#Test preloads lol
var dash = preload("res://07-Abilities/01-Dash/Dash.tscn")
var ice_spear = preload("res://07-Abilities/04-Icicle Spear/Icicle_Spear.tscn")
#========================


#We keep a dictionary of everything that is avaliable to us in here too.
var ability_dictionary: Dictionary = {
}

#bind dictionary aka we hit these keys and it calls some shit
var bind_dictionary:Dictionary = {
	"spacebar": null,
	"one": null,
	"two": null,
	"three": null,
	"four": null,
	"five": null,
}
var parent_body:CharacterBody2D

func _ready():
	var nodetest = dash.instantiate()
	self.add_child(nodetest)
	self.add_ability("dash", nodetest)
	self.set_bind_dictionary("spacebar", "dash")
	
	var nodetest2 = ice_spear.instantiate()
	self.add_child(nodetest2)
	self.add_ability("ice_spear", nodetest2)
	self.set_bind_dictionary("one", "ice_spear")

#We set the bind key to the ability dictionary key
func set_bind_dictionary(target_bind, ability_dictionary_key):
	bind_dictionary[target_bind] = ability_dictionary_key

#These need to re redone, cause idk what i was thinkin there
#Adds an ability to the dictionary of this thing.
func add_ability(given_key, object):
	ability_dictionary[given_key] = object
	object.linked_body = get_parent()

#Removes an ability from the dictionary of this thing.
func remove_ability(given_key):
	ability_dictionary.erase(given_key)

#We receive a key string
#We then find the ability on the ability dictionary
#Then we fire it
func fire_bindkey(given_key):
	if bind_dictionary[given_key]:
		ability_dictionary[bind_dictionary[given_key]].fire_ability()
		parent_body.animationState.travel("Attack")
		
		
		
		
		
		
