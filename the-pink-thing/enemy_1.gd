extends CharacterBody2D

class_name Enemy1

@export var speed : int  = 100 # How fast the player will move (pixels/sec).
@export var damage : int  = 10
@export var health : float = 50

var gravity = 1000
var facing_right : bool = false
var attacking : bool = false
var body_being_attacked = null

func hit(demage : int):
	health -= demage
	if (health <= 0):
		die()
		queue_free()

func _ready():
	add_to_group("enemy_group")
	$TwoHeads.play("walk")
	
func _physics_process(delta):
	if not is_on_floor(): # Add the gravity.
		velocity.y += gravity * delta
	
	if $Wall.is_colliding() && is_on_floor():
		flip()
	
	if attacking:
		$TwoHeads.play("attack")
		velocity.x = 0
	else: 
		if facing_right:
			velocity.x = speed
		else:
			velocity.x = -speed
	
	if $Attack1.is_colliding():
		var collider = $Attack1.get_collider()
		if collider and collider.is_in_group("player_group"):
			if not attacking:
				attacking = true
	else:
		attacking = false
		$TwoHeads.play("walk")
	
	if $Attack2.is_colliding():
		var collider = $Attack2.get_collider()
		if collider and collider.is_in_group("player_group"):
			flip()
			
	if !$Floor.is_colliding() && is_on_floor():
		flip()
	
	#if

	move_and_slide()

func flip():
	if attacking: # Makes Enemy not to flip when it's coliding with Player.
		return
		
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		velocity.x = speed
	else:
		velocity.x = -speed

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func die():
	$TwoHeads.play("dead")

func _on_hit_box_body_entered(body):
	if body.is_in_group("player_group"):
		if body is Player:
			body_being_attacked = body
			$Timer.start()

func _on_timer_timeout():
	if attacking && body_being_attacked!=null:
		body_being_attacked.hit(damage)
		get_parent().find_child("Player").attacked_by_enemy()
		print("Two Heads hits Player.") 

func _on_hit_box_body_exited(body):
	if body_being_attacked == body:
		body_being_attacked = null
		attacking = false
		$Timer.stop()
