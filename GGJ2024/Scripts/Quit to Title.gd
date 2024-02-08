extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _unhandled_input(event):
	#if event is InputEventKey:
		#if event.pressed and event.keycode == KEY_ESCAPE:
			#get_tree().change_scene_to_file("res://Scenes/Jade stuff/Title Screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/Jade stuff/Title Screen.tscn")
