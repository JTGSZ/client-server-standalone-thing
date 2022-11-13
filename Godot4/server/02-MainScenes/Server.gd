extends Control
var multiplayer_peer = ENetMultiplayerPeer.new()



func _on_button_pressed():
	multiplayer_peer.create_server(
		$Menu/PortInput.text.to_int(),
		$Menu/MaxPlayerInput.text.to_int()
	)
	multiplayer.multiplayer_peer = multiplayer_peer
	$Menu.visible = false
