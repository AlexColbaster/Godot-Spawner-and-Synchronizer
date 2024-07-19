extends Node2D

@onready var player_scene = load("res://player.tscn")
const PORT = 8088
const GODOT_PATH = "4.3.exe"
const CLIENT_COUNT = 2
func _ready() -> void:
	if OS.has_feature("editor"):
		debug_clients()
	var peer = WebSocketMultiplayerPeer.new()
	if DisplayServer.get_name() == "headless":
		print("server started")
		peer.create_server(PORT)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(add_player)
	else:
		print("client started")
		peer.create_client("ws://127.0.0.1:"+str(PORT))
		multiplayer.multiplayer_peer = peer

func add_player(id: int) -> void:
	var player = player_scene.instantiate()
	player.name = str(id)
	add_child(player)

func debug_clients():
	OS.execute("CMD.exe", ["/C", GODOT_PATH+' --export-debug "Windows Desktop" ./client.exe'])
	for i in range(CLIENT_COUNT):
		OS.create_process("client.exe", [], true)
