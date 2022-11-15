extends Control
var multiplayer_peer = ENetMultiplayerPeer.new()

var connected_peer_ids = []

func _on_button_pressed():
	multiplayer_peer.create_server(
		9999,
		32
#		$Menu/PortInput.text.to_int(),
#		$Menu/MaxPlayerInput.text.to_int()
	)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	print("Server Started")
	multiplayer_peer.peer_connected.connect(
		func(new_peer_id):
			await get_tree().create_timer(1).timeout
			print("peer connected")
			#Generic call to eerything
			rpc("add_newly_connected_player_character", new_peer_id)
			#This sends a call to a specific peer id, we call add_previously_connected_player_characters
			#Then we send it connected_peer_ids array
			rpc_id(new_peer_id, "add_previously_connected_player_characters", connected_peer_ids)
			add_player_character(new_peer_id)
	)
	
	$Menu.visible = false
	
func add_player_character(peer_id):
	connected_peer_ids.append(peer_id)
	var player_character = preload("res://04-PlayerBodies/PlayerTemplate.tscn").instantiate()
	player_character.set_multiplayer_authority(peer_id)
	
	var fuck = $Map/PrimaryYSort
	fuck.add_child(player_character)
	
@rpc(call_remote)	
func add_newly_connected_player_character(new_peer_id):
	pass
	
@rpc(call_remote)
func add_previously_connected_player_characters(peer_ids):
	pass
	
@rpc(call_remote)
func add_player_controller():
	pass
