extends Node

#Basically this is just a node that holds abilities
#We keep a dictionary of everything that is avaliable to us in here too.

var ability_dictionary: Dictionary = {}
var parent_body:CharacterBody2D

#Adds an ability to the dictionary of this thing.
func add_ability(given_key, object):
	ability_dictionary[given_key] = object

#Removes an ability from the dictionary of this thing.
func remove_ability(given_key):
	ability_dictionary.erase(given_key)
	
