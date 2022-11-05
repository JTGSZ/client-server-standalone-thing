extends Node

var mapstart = preload("res://02-MainScenes/Map.tscn")
var player_body = preload("res://04-PlayerBodies/PlayerTemplate.tscn")
var playercontroller = preload("res://03-Player_Controller/Player_Controller.tscn")


func _ready():
	var mapstart_instance = mapstart.instance()
	add_child(mapstart_instance)
	
	var player_body_instance = player_body.instance()
	var playercontroller_instance = playercontroller.instance()
	
	var primary_ysort = mapstart_instance.get_node("PrimaryYSort")
	primary_ysort.add_child(player_body_instance)
	
	mapstart_instance.add_child(playercontroller_instance)
	
	ActorController.add_to_controllable_mobs(player_body_instance)
	playercontroller_instance.swap_to_next_mob()

	
