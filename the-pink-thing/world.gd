extends Node2D

const enemy1 : PackedScene = preload("res://enemy_1.tscn")
const enemy2 : PackedScene = preload("res://enemy_2.tscn")
const diamond : PackedScene = preload("res://diamonds.tscn")
const heart : PackedScene = preload("res://hearts.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Main_Music.play()
	for respawn in $EnemySpawner.get_children():
		var enemy1_instance = enemy1.instantiate()
		add_child(enemy1_instance)
		enemy1_instance.global_position = respawn.global_position
		enemy1_instance.scale.x = 1
		
	for respawn in $Enemy2Spawner.get_children():
		var enemy2_instance = enemy2.instantiate()
		add_child(enemy2_instance)
		enemy2_instance.global_position = respawn.global_position
		enemy2_instance.scale.x = 1
		
	for respawn in $DiamondSpawner.get_children():
		var diamond_instance = diamond.instantiate()
		add_child(diamond_instance)
		diamond_instance.global_position = respawn.global_position

	for respawn in $HeartSpawner.get_children():
		var heart_instance = heart.instantiate()
		add_child(heart_instance)
		heart_instance.global_position = respawn.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func send_post_new_score(username: String, diamonds: int):
	if username == null:
		printerr("Will NOT send POST data with score due to invalid username")
		printerr("There might have been an error loading user_data file")
		return
	var body = JSON.stringify({"username": username, "score": (diamonds*100)})
	var headers = ["Content-Type: application/json", "Client-Secret: abc"]
	$HTTPRequest.request("http://127.0.0.1:8000/score", headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	print("Server response:")
	print(response)
