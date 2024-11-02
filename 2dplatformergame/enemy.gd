# Enemy script
extends CharacterBody2D

@export var speed: float = 100.0
@export var left_boundary: Vector2
@export var right_boundary: Vector2

var direction: int = 1  # Direction to move (1 for right, -1 for left)

func _physics_process(delta: float) -> void:
	if (direction == 1 and position.x >= right_boundary.x) or (direction == -1 and position.x <= left_boundary.x):
		direction *= -1
	var velocity = Vector2(speed * direction, 0)
	move_and_slide()

# When the player collides, kill the player
func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		body.take_damage()  # This function will handle the player's death
