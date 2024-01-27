extends PinJoint2D

@export var angular_friction : float = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var a = get_node(node_a) as RigidBody2D
	var b = get_node(node_b) as RigidBody2D
	
	var omega_a_pre = a.angular_velocity
	var omega_b_pre = b.angular_velocity
	
	var omega_rel = omega_b_pre - omega_a_pre
	var omega_rel_dir = sign(omega_rel)
	
	#a.apply_torque(20000)
	
	var total_inertia = a.mass + b.mass
	
	a.apply_torque(omega_rel * angular_friction * total_inertia)
	b.apply_torque(-omega_rel * angular_friction * total_inertia)
	var omega_a_post = a.angular_velocity
	var omega_b_post = b.angular_velocity
	
	var omega_post_rel = omega_b_post - omega_a_post
	var omega_post_rel_dir = sign(omega_post_rel)
	
	if omega_post_rel_dir == -omega_rel_dir:
		var relative_stop_omega = (omega_a_pre + omega_b_pre + omega_a_post + omega_b_post) / 4.0
		a.angular_velocity = relative_stop_omega
		b.angular_velocity = relative_stop_omega
	
