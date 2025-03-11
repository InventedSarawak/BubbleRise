extends Node

# Current score of the player
var current_score = 0

# Label to display the score
@onready var score_label = $ScoreLabel

func _ready():
	# Initialize the score display
	update_score_display()

func increment_score(amount: int) -> void:
	# Add to the current score
	current_score += amount
	
	# Update the score display
	update_score_display()

func update_score_display() -> void:
	# Update the text of the score label
	if score_label:
		score_label.text = "Score: " + str(current_score)
