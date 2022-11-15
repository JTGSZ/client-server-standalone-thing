extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#By default this returns false, which is why you see like the red x when you drag and hover over something.
#all control nodes apparently run it, but in this case we like redefine some shit and return true

#Data is the data we return in the function on the dragged ui node in _get_drag_data()
#So this would be where you'd check to make sure its valid to drop data in, and we can move to the next func
func _can_drop_data(at_position, data):
	return true #in any case yeah we can drop data into here


#We dragged over the panel
#Can drop data returned true and they released it into us
#Its gotime, we receive the data crammed in on the original drag action
#Now we handle it appropriately.
func _drop_data(at_position, data):
	print(data)
	var the_item:TextureRect = data["the_item"]
	var prior_slot:Panel = data["the_slot"]
	
	#We remove the item from its parent
	prior_slot.remove_child(the_item)
	#Cram the item back in as a child of this slot lol
	self.add_child(the_item)
	
	#Just cause you reparent it don't mean u change its display position
	#We set the item to its new position, aka under the mouse.
	the_item.position = at_position
	
	#Got a problem tho, the item's point is the top left
	#Thusly, we subtract the coordinate size of it divided by two from each axis.
	#Making it exact to the mouse dropoff point
	the_item.position.x -= the_item.size.x/2
	the_item.position.y -= the_item.size.y/2
	


	


