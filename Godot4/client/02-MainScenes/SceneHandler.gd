extends Node
#this is basically the first node loaded in and the root of everything I guess
#TODO: 11/9/2022
# Make game area a viewport, the standard viewport will be over everything and be the UI layer so we can add the chatbox etc
#Along with not have menus be weird
#
var mapstart = preload("res://02-MainScenes/Map.tscn")
var player_body = preload("res://04-PlayerBodies/PlayerTemplate.tscn")
var playercontroller = preload("res://03-Player_Controller/Player_Controller.tscn")



var multiplayer_peer = ENetMultiplayerPeer.new()
const PORT = 9999
const ADDRESS = "127.0.0.1"
var connected_peer_ids = []

#What we start with lol
func _ready():
	pass
#	var mapstart_instance = mapstart.instantiate()
#	add_child(mapstart_instance)
	
#	var player_body_instance = player_body.instantiate()
#	var playercontroller_instance = playercontroller.instantiate()
#	add_child(playercontroller_instance)
#	var primary_ysort = mapstart_instance.get_node("PrimaryYSort")
#	primary_ysort.add_child(player_body_instance)
	
#	mapstart_instance.add_child(playercontroller_instance)
	
#	ActorController.add_to_controllable_mobs(player_body_instance)
#	playercontroller_instance.swap_to_next_mob()

#func _on_chat_window_focus_entered():
#	ActorController.inputs_enabled = false
#
#
#func _on_chat_window_focus_exited():
#	ActorController.inputs_enabled = true

func _on_join_button_pressed():
	#DO SHIT
	$JoinButton.visible = false
	multiplayer_peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
	$PeerID.text = str(multiplayer.get_unique_id())

@rpc
func add_player_controller():
	var playercontroller_instance = playercontroller.instantiate()
	add_child(playercontroller_instance)
#	ActorController.add_to_controllable_mobs(local_body)
	print("controller added")


@rpc
func add_newly_connected_player_character(peer_id):
	add_player_character(peer_id)

func add_player_character(peer_id):
	var fuck = player_body.instantiate()
	fuck.set_multiplayer_authority(peer_id)
	$Map/PrimaryYSort.add_child(fuck)
	return fuck
	
@rpc
func add_previously_connected_player_characters(peer_ids):
	for peer_id in peer_ids:
		add_player_character(peer_id)
		
