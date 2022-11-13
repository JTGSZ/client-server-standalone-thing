extends Sprite2D

#A independant sprite object, that just follows the mouse cursor until you release it.
#Ironically holds no data at all related to the drag lol
func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("left_mousebutton"):
		queue_free()
