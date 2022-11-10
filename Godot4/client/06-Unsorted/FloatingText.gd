extends Marker2D

#Refs to our children lol
@onready var label:Label = $Label

#physics nums for process loop and moving it
var velocity = Vector2(50, -100)
var gravity = Vector2(0, 1)
var mass = 200

#number to cram in
var amount = 0
#type related to what color we r gonna make it in the switch statement below
var type = "damage"
#If this is a critical of some sort
var critical = false

var max_size = Vector2(1, 1)
var text_color: Color = Color("ffffff")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	
	#Basically you can set a type, and change the color here i guess
	match type:
		"damage":
			if critical:
				text_color = Color("fa0000")
		"healing":
			text_color = Color("00c924")
				
			
	
	#If a critical pump the size up
	if critical:
		max_size = Vector2(1.5, 1.5)
	#set the text color depending checked where we reached
	label.set("custom_colors/font_color", text_color)
	
#	var tween = get_tree().create_tween()
	#where we start
#	tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	#move the alpha color down lol
#	tween.interpolate_property(self,'modulate', 
#	Color(modulate.r, modulate.g, modulate.b, modulate.a),
#	Color(modulate.r, modulate.g, modulate.b, 0.3),
#	0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.6)
	
	#scale text down after 0.3 seconds
#	tween.interpolate_property(self, 'scale', max_size, Vector2(0.8, 0.8), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)

	#Destroy the tween after 1 second
#	tween.interpolate_callback(self, 1.0, "destroy")
	
	#start the tween
#	tween.start()

func _process(delta):
	velocity += gravity * mass * delta
	position += velocity * delta

func destroy():
	self.queue_free()

