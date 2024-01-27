extends "res://Scripts/FrictionPinJoint2D.gd"

@export var target_direction = 0
@export var unrestrained_degrees = 30
@export var spring_k = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var a = get_node(node_a) as RigidBody2D
	var b = get_node(node_b) as RigidBody2D
	
	var relative_angle = b.global_rotation_degrees - a.global_rotation_degrees
	if abs(relative_angle) > 180:
		if relative_angle > 0:
			relative_angle = relative_angle - 360
		else:
			relative_angle = relative_angle + 360
	
	target_direction = target_direction % 360
	var target_directions = [target_direction - 360, target_direction, target_direction + 360]
	var target_deltas = target_directions.map(func(d): return relative_angle - d)
	var actual_delta = target_deltas.reduce(func(accum, number): return number if abs(number) < abs(accum) else accum)

	if abs(actual_delta) > unrestrained_degrees:
		var offset = abs(actual_delta) - unrestrained_degrees
		var corrective_torque = offset * spring_k * sign(actual_delta) * 1000
		
		a.apply_torque(corrective_torque)
		b.apply_torque(-corrective_torque)
