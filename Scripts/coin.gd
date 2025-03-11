extends Area2D

func _ready():
	body_entered.connect(Callable(self, "_on_coin_body_entered"))

func _on_coin_body_entered(body):
	# Check if the body is the Player.
	# (Alternatively, `if body is Player:` in Godot 4)
	if body.name == "Player":
		# Call the Player’s add_points() function:
		body.add_points(3)
		# Remove the coin.
		queue_free()
