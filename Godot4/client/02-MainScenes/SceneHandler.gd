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
const PORT = 6669
const ADDRESS = "127.0.0.1"
var connected_peer_ids = []

#What we start with lol
func _ready():
	pass

func _on_chat_window_focus_entered():
	ActorController.inputs_enabled = false


func _on_chat_window_focus_exited():
	ActorController.inputs_enabled = true

#You hit the join button and you join lol
func _on_join_button_pressed():
	#DO SHIT
	$JoinButton.visible = false
	multiplayer_peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
	$PeerID.text = str(multiplayer.get_unique_id())

#RPC basically means we are exposing this function. 
#It stands for remote procedure call after-all
@rpc
func add_newpeers_controller(peer_id):
	var playercontroller_instance = playercontroller.instantiate()
	add_child(playercontroller_instance)
#	ActorController.add_to_controllable_mobs(local_body)
	print("controller added")
	playercontroller_instance.set_as_current_camera()

#We add a newly connected player char
@rpc
func add_newly_connected_player_character(peer_id):
	add_player_character(peer_id)

#We add a player character and set the peer_id to it.
func add_player_character(peer_id):
	var fuck = player_body.instantiate()
	

	if peer_id == multiplayer.get_unique_id():
		ActorController.add_to_controllable_mobs(fuck)
		ActorController.player_controller.swap_to_next_mob()
		
	fuck.set_multiplayer_authority(peer_id)
	$Map/PrimaryYSort.add_child(fuck)
	return fuck

#Add all the bitches in before us lol
@rpc
func add_previously_connected_player_characters(peer_ids):
	for peer_id in peer_ids:
		add_player_character(peer_id)
		
