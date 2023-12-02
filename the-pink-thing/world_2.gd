extends Node2D

@onready var PLAYER = preload("res://player.tscn")

func _ready():
	var player = PLAYER.instantiate()
	add_child(player)
	player.global_position = $PlayerCoor.global_position
