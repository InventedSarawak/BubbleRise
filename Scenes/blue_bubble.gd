extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	connect("area_entered", Callable(self, "_on_Area2D_area_entered"))


func _on_Area2D_area_entered(area: Area2D):
	#if area.is_in_group("bullets"):  # Bubble pops when it hits a bullet
		_pop_bubble()
		#_trigger_chain_reaction()

# Function to handle popping the current bubble
func _pop_bubble():
	animated_sprite.play("explosion")  # Play pop animation
	await animated_sprite.animation_finished  # Wait for animation to finish
	queue_free()  # Remove the bubble
