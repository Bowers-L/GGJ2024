extends Camera2D

@export var target_pixels := 600
@export var kaiju : Node2D

var kaiju_body : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	kaiju_body = kaiju.get_node("Body")
	print(kaiju_body)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var height = get_viewport_rect().size.y
	var zoom_factor = height / target_pixels
	
	#zoom = Vector2(zoom_factor, zoom_factor)
	
	global_position.x = kaiju_body.global_position.x
	
	pass
