extends Area2D

#The SPEED of this thing
export(int) var projectile_speed = 200
#The lifetime of this thing, aka max and what we count up
export(int) var projectile_lifetime = 100

export(int) var damage = 10
var current_lifetime = 0
#Need a ref to our caster so we don't self-collide and fuck ourselves up.
var origin_caster:KinematicBody2D

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += projectile_speed * direction * delta
	current_lifetime += 1
	if current_lifetime >= projectile_lifetime:
		self.destroy()
		
func destroy():
	queue_free()

func _on_Spell_body_entered(body):
	if body != origin_caster:
		destroy()

func _on_Spell_area_entered(area):
	var thing_hit = area.get_parent()
	if thing_hit != origin_caster:
		thing_hit.spell_hit(10)
		queue_free()
