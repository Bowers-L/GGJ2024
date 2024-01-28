class_name Building
extends Node2D

@export var break_rows := 2
@export var break_cols := 2

@export var break_depth := 3

@onready var detection_area := $Area2D
@onready var rigidbody := $RigidBody2D
@onready var sprite := $RigidBody2D/Sprite2D
@onready var area_shape := ($Area2D/CollisionShape2D)
@onready var rb_shape := ($RigidBody2D/CollisionShape2D)

@onready var fragment_scene := load("res://Scenes/BuildingTemplate.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	resize_collider_to_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func area_triggered(body: Node2D):
	call_deferred("split_or_activate")

func split_or_activate():
	if (break_depth > 0):
		for i in break_rows:
			for j in break_cols:
				var instance = fragment_scene.instantiate()
				get_parent().add_child(instance)
				instance.initialize_as_fragment(self, j, i)
		queue_free()
	else:
		rigidbody.freeze = false
		detection_area.monitoring = false
		
		var shape = RectangleShape2D.new()
		shape.size.x = area_shape.shape.size.x
		shape.size.y = area_shape.shape.size.y
		
		rb_shape.shape = shape
		#print("Activating rb. rb collider size: ", rb_shape.size)
	
func initialize_as_fragment(parent_frag : Building, index_x, index_y):
	sprite.texture = parent_frag.sprite.texture
	sprite.hframes = parent_frag.sprite.hframes * parent_frag.break_cols
	sprite.vframes = parent_frag.sprite.vframes * parent_frag.break_rows
	sprite.frame_coords.x = parent_frag.sprite.frame_coords.x * parent_frag.break_cols + index_x
	sprite.frame_coords.y = parent_frag.sprite.frame_coords.y * parent_frag.break_rows + index_y
	sprite.scale = parent_frag.sprite.scale
	
	#var parent_shape := parent_frag.area_shape
	##print("Area shape size: ", area_shape.size)
	#
	#var shape = RectangleShape2D.new()
	#
	#shape.size.x = parent_shape.shape.size.x / break_cols
	#shape.size.y = parent_shape.shape.size.y / break_rows
	#
	#area_shape.shape = shape
	
	resize_collider_to_sprite()
	
	var shape = area_shape.shape
	
	global_position = parent_frag.global_position
	global_position.x += shape.size.x * -((parent_frag.break_cols - 1)/2.0 - index_x)
	global_position.y += shape.size.y * -((parent_frag.break_rows - 1)/2.0 - index_y)
	
	break_depth = parent_frag.break_depth - 1
	

func resize_collider_to_sprite():
	var sprite_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())
	sprite_size /= Vector2(sprite.hframes, sprite.vframes)
	sprite_size *= sprite.global_scale
	
	var shape = RectangleShape2D.new()
	
	shape.size = sprite_size
	
	area_shape.shape = shape
	

func _on_collision(body):
	if (body.collision_layer & 0b10):
		rigidbody.collision_mask &= ~0b1
