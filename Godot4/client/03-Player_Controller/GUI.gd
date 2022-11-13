extends CanvasLayer


@onready var abilitybook = $AbilityBook
@onready var skillbar = $Skillbar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#button toggle
func _on_ability_book_toggle_pressed():
	abilitybook.visible = !abilitybook.visible


