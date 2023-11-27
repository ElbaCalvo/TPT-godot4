extends Node2D

func _process(_delta):
		$AnimatableBody2D/Path2D/AnimationPlayer.play("movement")
