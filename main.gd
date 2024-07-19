extends Node2D

@onready var player_scene = load("res://player.tscn")
const PORT = 8088
func _ready() -> void:
	var peer = ENetMultiplayerPeer.new()
	if DisplayServer.get_name() == "headless":
		print("server started")
		peer.create_server(PORT)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(add_player)
	else:
		print("client started")
		peer.create_client("127.0.0.1", PORT)
		multiplayer.multiplayer_peer = peer

func add_player(id: int) -> void:
	var player = player_scene.instantiate()
	player.name = str(id)
	add_child(player)
