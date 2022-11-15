extends TextureButton

@export var our_bind = "one"
var toggle_data = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _can_drop_data(at_position, data):
	if data["ability_name"]:
		return true #in any case yeah we can drop data into here
		
#We dragged over the panel
#Can drop data returned true and they released it into us
#Its gotime, we receive the data crammed in on the original drag action
#Now we handle it appropriately.
func _drop_data(at_position, data):
	
	var texture_name = data["texture_name"]
	var ability_name = data["ability_name"]
	
	var loaded_texture = load("res://Assets/AbilityIcons/" + texture_name + ".png")
	
	
	toggle_data = ability_name
	texture_normal = loaded_texture
	
	print("Redo this in HotButtonButotn etc lol")
#	ActorController.player_controller.current_body.AbilityHolder.set_bind_dictionary(our_bind, toggle_data)

#func _on_button_up():
#	if toggle_data:
#		print("we hit?")
#		ActorController.player_controller.current_body.AbilityHolder.fire_bindkey(our_bind)
