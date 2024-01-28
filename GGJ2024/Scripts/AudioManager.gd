extends Node

var has_played := false
@export var event: EventAsset

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_sound():
	FMODRuntime.play_one_shot(event)
	has_played = true

func check_if_playable():
	if(has_played):
		await get_tree().create_timer(3).timeout
		has_played = false
	else:
		play_sound()
		

