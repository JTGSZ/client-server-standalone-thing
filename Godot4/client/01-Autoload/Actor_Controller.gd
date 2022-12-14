extends Node

#Basically a singleton loaded in that handles a buncha shit lol
#what characters we can control manually
var controllable_characters:Array = []

#The body we currently have selected
var currently_selected: CharacterBody2D

#If our inputs are enabled
var inputs_enabled = true

#Our player_controller/UI stuff
var player_controller

func _ready():
	pass # Replace with function body.


#------------------------
#		HELPERS
#------------------------
#Add to array of mobs we can control
func add_to_controllable_mobs(added_character: CharacterBody2D):
	self.controllable_characters.append(added_character)

#Remove from array of mobs we can control
func remove_from_controllable_mobs(removed_character: CharacterBody2D):
	var character_index = self.controllable_characters.find(removed_character)
	self.controllable_characters.remove_at(character_index)

func selected_target(target):
	#If the target is the same as thing we currently selected, just deselect it.
	if target == currently_selected:
		currently_selected.selected(false)
		currently_selected = null
		player_controller.targetbody_healthbar.visible = false
	else:
		#If we are clicking checked another target deselect and then select the new one.
		if currently_selected:
			currently_selected.selected(false)
		
		currently_selected = target
		player_controller.targetbody_healthbar.visible = true
		player_controller.update_healthbar(target)
		target.selected(true)
		

