extends Node2D

const BULLET = preload("res://Assets/Sprites/Gun/bullet/bullet.tscn")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_just_pressed("fire"):
		# 1) Spawn the bullet
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.rotation = rotation

		# 2) Decrement the player's score by 1
		var player = get_parent()  # "gun" is a child of "Player"
		if player and player.has_method("add_points"):
			player.add_points(-1)  # This makes the score go down by 1
