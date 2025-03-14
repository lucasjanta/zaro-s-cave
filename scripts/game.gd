extends Node

@onready var multiplayer_ui = $UI/MultiplayerControl

const PLAYER = preload("res://scenes/Characters/player.tscn")

var peer = ENetMultiplayerPeer.new()


func _on_host_button_pressed():
	peer.create_server(25565)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + "has joined the game!")
			add_player(pid)
	)
	
	add_player(multiplayer.get_unique_id())

	multiplayer_ui.hide()

func _on_join_button_pressed():
	peer.create_client("localhost", 25565)
	multiplayer.multiplayer_peer = peer
	multiplayer_ui.hide()

func add_player(pid):
	var player = PLAYER.instantiate()
	player.name = str(pid)
	add_child(player)
	
