extends Node2D

class_name Main

signal gained_diamonds(int)

var diamonds : int

func _ready():
	$Music.play()

func _process(_delta):
	pass

func gain_diamonds(diamonds_gained : int):
	diamonds += diamonds_gained
	emit_signal("gained_diamonds", diamonds_gained)
	print("diamonds")
