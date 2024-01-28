extends Node2D

@export var building_options : Array[PackedScene]
@export var min_building_dist := 200
@export var max_building_dist := 400
@export var building_count := 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	for i in building_count:
		var scene = building_options.pick_random()
		var instance = scene.instantiate()
		get_parent().add_child.call_deferred(instance)
		instance.global_position = global_position
		global_position.x += randf_range(min_building_dist, max_building_dist)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
