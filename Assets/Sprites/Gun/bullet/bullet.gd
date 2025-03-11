extends Area2D

const SPEED: int = 150
 
 
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
 
func _on_body_entered(body):
	# Destroy the bullet on collision
	queue_free()
