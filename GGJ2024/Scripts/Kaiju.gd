extends Node2D

@export var left_foot : RigidBody2D
@export var right_foot : RigidBody2D
@export var foot_friction := .15
@export var controller_sensitivity := 6.0
@export var foot_range := 300.0

var left_up := false
var right_up := false
var mouse_delta := Vector2()
var controller_move := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_delta += event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var leg_state_changed = false
	if Input.is_action_just_pressed("Left Leg Up"): 
		left_up = true
		leg_state_changed = true
	if Input.is_action_just_pressed("Right Leg Up"):
		right_up = true
		leg_state_changed = true
	if Input.is_action_just_released("Left Leg Up"):
		left_up = false
		leg_state_changed = true
	if Input.is_action_just_released("Right Leg Up"):
		right_up = false
		leg_state_changed = true
		
	if leg_state_changed:
		if (left_up == right_up):
			drop_foot(left_foot)
			drop_foot(right_foot)
		elif left_up:
			lift_foot(left_foot)
			drop_foot(right_foot)
		elif right_up:
			lift_foot(right_foot)
			drop_foot(left_foot)
	
	controller_move = Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	

func lift_foot(foot: RigidBody2D):
	#foot.mass = 10000
	foot.gravity_scale = 0
	foot.physics_material_override.friction = 0
	pass
	
func drop_foot(foot: RigidBody2D):
	#foot.mass = foot_weight
	foot.gravity_scale = 1
	foot.physics_material_override.friction = foot_friction
	pass

func move_foot(foot: RigidBody2D, other_foot: RigidBody2D):
	
	
	var move_direction = Vector2(0,0)
	move_direction += mouse_delta
	move_direction += controller_move * controller_sensitivity
	
	
	var foot_separation = foot.global_position - other_foot.global_position
	var dot = move_direction.normalized().dot(foot_separation.normalized())
	if foot_separation.length() > foot_range and dot > 0:
		var overage = foot_separation.length() - foot_range
		var damp = 1/(1+overage)
		var damped_movement = damp * move_direction
		move_direction = lerp(move_direction, damped_movement, dot)
		
	
	foot.move_and_collide(move_direction);
	


func _physics_process(delta):
	
	
	if left_up and right_up:
		pass
	elif left_up:
		move_foot(left_foot, right_foot)
	elif right_up:
		move_foot(right_foot, left_foot)
	mouse_delta = Vector2()
