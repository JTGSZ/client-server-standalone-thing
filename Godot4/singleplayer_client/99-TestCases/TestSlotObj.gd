extends TextureRect

#This is just a sprite scene
var drag_preview = preload("res://99-TestCases/drag_preview.tscn")

var object_type = "ability"

#When we click and drag this fires off
#We put the data we need to pass over to the thing we are dropping on in the return
#specifically this fires on the control node we are clicking and dragging on

#We have a inbuilt method to find out if dragpreview works 
#but i don't feel like finding out if its good to go

#Also for more information this is a control node thing, so they all have the funcs
func _get_drag_data(at_position: Vector2):
	var data = {}
	data["the_item"] = self
	data["the_slot"] = get_parent()
	
	var dragpreview: Sprite2D = drag_preview.instantiate()
	dragpreview.texture = texture
	add_child(dragpreview)
	
	return data
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


