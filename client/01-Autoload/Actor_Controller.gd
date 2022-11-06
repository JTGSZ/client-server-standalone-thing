extends Node

#Basically a singleton loaded in that lets us know what things we can control with our camera thing.

var controllable_characters:Array = []

var currently_selected: KinematicBody2D

func _ready():
	pass # Replace with function body.


#------------------------
#		HELPERS
#------------------------
#Add to array of mobs we can control
func add_to_controllable_mobs(added_character: KinematicBody2D):
	self.controllable_characters.append(added_character)

#Remove from array of mobs we can control
func remove_from_controllable_mobs(removed_character: KinematicBody2D):
	var character_index = self.controllable_characters.find(removed_character)
	self.controllable_characters.remove(character_index)

func selected_target(target):
	#If the target is the same as thing we currently selected, just deselect it.
	if target == currently_selected:
		currently_selected.selected(false)
		currently_selected = null
	else:
		#If we are clicking on another target unselect and then select the new one.
		if currently_selected:
			currently_selected.selected(false)
		
		currently_selected = target
		target.selected(true)
