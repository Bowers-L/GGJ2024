extends Node

var deaths := 0

signal new_death_count(value)

func _on_deaths_reported(num: int):
	deaths += num
	emit_signal("new_death_count", deaths)
	print("deaths: ", deaths)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
