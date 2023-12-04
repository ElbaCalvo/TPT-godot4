extends CanvasLayer

var timeout = false

func change_level():
	$AnimationPlayer.play("disolve")
	$Timer.start()
	
func _on_timer_timeout():
	if timeout == false:
		timeout = true
		$AnimationPlayer.play_backwards("disolve")
		get_node("/root/Main/World1/Player").can_move = true
