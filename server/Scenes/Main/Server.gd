extends Node

#make new node lol
var network = NetworkedMultiplayerENet.new()
# port number obv what this be
var port = 1909
#req field ironically
var max_players = 100

func _ready():
	StartServer();
	
func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	
	#Attach some signals to the network node
	#these ones fire off when we have a peer connect or disconnect
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(player_id):
	print("User " + str(player_id) + " Connected")
	
func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " Disconnected")
