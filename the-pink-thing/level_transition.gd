extends CanvasLayer

var timeout = false

func change_level():
	$AnimationPlayer.play("disolve")
	$Timer.start()
	
func _on_timer_timeout():
	if timeout == false:
		timeout = true
		$AnimationPlayer.play_backwards("disolve")
		get_parent().find_child("Player").can_move = true
