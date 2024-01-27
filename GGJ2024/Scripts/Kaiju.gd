extends Node2D

@export var left_foot : RigidBody2D
@export var right_foot : RigidBody2D
@export var foot_weight := 100.0

var left_up := false
var right_up := false
var mouse_delta := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Left Leg Up"): 
		left_up = true
		lift_foot(left_foot)
	if Input.is_action_just_pressed("Right Leg Up"):
		right_up = true
		lift_foot(right_foot)
	if Input.is_action_just_released("Left Leg Up"):
		left_up = false
		drop_foot(left_foot)
	if Input.is_action_just_released("Right Leg Up"):
		right_up = false
		drop_foot(right_foot)

func lift_foot(foot: RigidBody2D):
	#foot.mass = 10000
	foot.gravity_scale = 0
	pass
	
func drop_foot(foot: RigidBody2D):
	#foot.mass = foot_weight
	foot.gravity_scale = 1
	pass

func move_foot(foot: RigidBody2D):
	var move_direction = Vector2(0,0)
	move_direction += mouse_delta
	
	foot.move_and_collide(move_direction);
	


func _physics_process(delta):
	if left_up and right_up:
		pass
	elif left_up:
		move_foot(left_foot)
	elif right_up:
		move_foot(right_foot)
