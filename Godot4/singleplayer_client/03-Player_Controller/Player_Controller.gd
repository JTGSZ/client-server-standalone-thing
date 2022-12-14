extends Marker2D

var current_body: CharacterBody2D
var following_mob: bool = false

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

@onready var ourbody_healthbar: TextureProgressBar = $GUI/HSplitContainer/OurHealthbar
@onready var targetbody_healthbar: TextureProgressBar = $GUI/HSplitContainer/TargetHealthbar

func _ready():
	ActorController.player_controller = self

func _physics_process(_delta):
	follow_controlled_mob()

#	read_input()

func update_healthbar(body_to_update):
		if current_body == body_to_update:
			ourbody_healthbar.value = int((float(body_to_update.current_health) / body_to_update.max_health) * 100 )
		
		if body_to_update == ActorController.currently_selected:
			targetbody_healthbar.value = int((float(body_to_update.current_health) / body_to_update.max_health) * 100 )
	
func follow_controlled_mob():
	if current_body && following_mob:
		self.position = current_body.position

func _input(_event):
	if ActorController.inputs_enabled:
		#tab mob control swaps
		if(Input.is_action_just_released("tab")):
			swap_to_next_mob()
		
		#if(Input.is_action_just_pressed("left_mousebutton")):
			#print(event)
		

#------------------------
#		HELPERS
#------------------------
#We take control of a mob
func take_control_of_mob():
	if ActorController.controllable_characters.size() != 0:
		if current_body:
			current_body.body_player_controlled = false
			following_mob = false
			current_body = null
		else:
			following_mob = true
			current_body = ActorController.controllable_characters[0]
			current_body.body_player_controlled = true
	else:
		print("No mobs to control")

#We swap to next mob in the array of shit we can control
func swap_to_next_mob():
	if(!current_body):
		take_control_of_mob()
	else:
		current_body.body_player_controlled = false
		var curmob_index = ActorController.controllable_characters.find(current_body)
		var curmob_size = ActorController.controllable_characters.size()
		var curmob_next_val = 0
		
		if curmob_index > -1:
			curmob_next_val = curmob_index+1
			if curmob_next_val > curmob_size-1:
				curmob_next_val = 0
			current_body = ActorController.controllable_characters[curmob_next_val]
			current_body.body_player_controlled = true

