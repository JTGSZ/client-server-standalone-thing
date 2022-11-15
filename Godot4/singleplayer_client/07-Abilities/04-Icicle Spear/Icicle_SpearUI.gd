extends TextureRect

var drag_preview = preload("res://09-UI_Stuff/drag_preview.tscn")
var object_type = "ability"

func _get_drag_data(at_position: Vector2):
	var data = {}
	data["ability_name"] = "icicle_spear"
	data["texture_name"] = "ice-spear"
	
	var dragpreview: Sprite2D = drag_preview.instantiate()
	
	#Resizes whatev texture to the sizeto, so you don't have the 512x512 texture as preview
	var sizeto = Vector2(40, 40)
	var size = texture.get_size()
	var scale_factor = sizeto/size
	dragpreview.scale = scale_factor
	
	dragpreview.texture = texture
	add_child(dragpreview)
	
	return data
