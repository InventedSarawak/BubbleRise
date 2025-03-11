extends Node2D

var grid = []
var rows = 20
var columns = 20
var cell_size = Vector2(14, 14)  # Size of each bubble's grid cell

# Preload scenes
@export var red_bubble: PackedScene = preload("res://Scenes/red_bubble.tscn")
@export var blue_bubble: PackedScene = preload("res://Scenes/blue_bubble.tscn")
@export var green_bubble: PackedScene = preload("res://Scenes/green_bubble.tscn")

func _ready() -> void:
	for y in range(rows):
		grid.append([])
		for x in range(columns):
			grid[y].append(null)  # Empty cells
	populate_grid()

func get_random_bubble_scene() -> PackedScene:
	var random = randi() % 3
	if random == 0:
		return red_bubble
	elif random == 1:
		return green_bubble
	else: 
		return blue_bubble 

func populate_grid() -> void:
	for y in range(rows):
		for x in range(columns):
			var bubble_scene = get_random_bubble_scene()

			if bubble_scene is PackedScene:
				var bubble = bubble_scene.instantiate()  # Instantiate the bubble
				bubble.position = Vector2(x * cell_size.x, y * cell_size.y -900)  # Set position

				# Set gravity scale to 0 to disable gravity
				if bubble is RigidBody2D:
					bubble.gravity_scale = 0

				add_child(bubble)  # Add the bubble to the scene tree
				grid[y][x] = bubble
			else:
				print("Error: Not a valid PackedScene!")

func _process(_delta: float) -> void:
	pass
