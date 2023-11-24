extends CharacterBody2D

class_name Player

var screen_size # Size of the game window.
var gravity = 1000
var body_being_attacked = null
var jump_force : int = 450
var attacking : bool = false

@export var actual_health = 100
@export var speed :int = 100 # How fast the player will move (pixels/sec).
@export var damage : int  = 10
@export var health = 100

func hit(demage : int):
	health -= demage
	if (health <= 0):
		die()
		queue_free()

func _ready():
	add_to_group("player_group")

func _process(_delta):
	pass
	
func _physics_process(delta):
	var direction = Input.get_axis("walk_left","walk_right") # Get input direction
	
	if Input.is_action_pressed("walk_left"):
		$Character.flip_h = direction < 0 # Flip the Character's direction.
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1 # Flip AttackArea's direction.
	if Input.is_action_pressed("walk_right"):
		$Character.flip_h = direction < 0 # Flip the Character's direction.
		$AttackArea.scale.x = abs($AttackArea.scale.x) * 1 # Flip AttackArea's direction.
	
	if not is_on_floor(): # Add the gravity.
		velocity.y += gravity * delta
	
	# Jump if on the floor and jump key is pressed.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	update_animations()
	move_and_slide()
	
	if Input.is_action_pressed("attack") && is_on_floor():
		attack()
	else:
		attacking = false

func update_animations():
	if !attacking:
		if velocity.x != 0:
			if Input.is_action_pressed("run"):
				speed = 150
				if is_on_floor():
					$Character.play("run")
			else:
				speed = 100
				if is_on_floor():
					$Character.play("walk")
		else:
			if is_on_floor():
				$Character.play("idle")
	if !is_on_floor():
		$Character.play("jump")

func attack():
	attacking = true
	$Character.play("attack2")
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func die():
	$Character.play("death")
	
func _on_attack_area_body_entered(body):
	if body.is_in_group("enemy_group"):
		if (body is Enemy1) or (body is Enemy2):
			body_being_attacked = body
			$Timer.start()

func _on_timer_timeout():
	if attacking && body_being_attacked!=null:
		body_being_attacked.hit(damage)
		attacked_by_enemy()
		print("Player hits an Enemy.")

func _on_attack_area_body_exited(body):
	if body_being_attacked == body:
		body_being_attacked = null
		attacking = false
		$Timer.stop()

func attacked_by_enemy():
	actual_health -= damage
	get_node("/root/Main/World/GUI").update_health_value(actual_health)
	
