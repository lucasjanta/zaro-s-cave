extends Node

@onready var multiplayer_ui = $UI/MultiplayerControl

const PLAYER = preload("res://scenes/Characters/player.tscn")

var peer = ENetMultiplayerPeer.new()
var players : Array[Player] = []

func _ready():
	$MultiplayerSpawner.spawn_function = add_player

func _on_host_button_pressed():
	peer.create_server(25565)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + "has joined the game!")
			add_player(pid)
			$MultiplayerSpawner.spawn(pid)
	)
	$MultiplayerSpawner.spawn(multiplayer.get_unique_id())
	multiplayer_ui.hide()

func _on_join_button_pressed():
	peer.create_client("localhost", 25565)
	multiplayer.multiplayer_peer = peer
	multiplayer_ui.hide()

func add_player(pid):
	var player = PLAYER.instantiate()
	player.name = str(pid)
	player.global_position = $Level.get_child(players.size()).global_position
	players.append(player)
	return player
	
