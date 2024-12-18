# Player script
extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSfx.play()
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction == -1
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
	
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	move_and_slide()

# Handle the player death
func take_damage():
	# Optionally play a sound, show a death animation, etc.
	get_tree().reload_current_scene()  # Restart the level
