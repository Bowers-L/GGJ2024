extends TextureRect

@onready var file = 'res://misc/ticket_lines.txt'
@onready var labelObj = preload("res://Scenes/Jade stuff/ticket label.tscn")
@export var scrollSpeed = -150
var textArray = []
var workingTextArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_file(file)
	
	createLabel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveLabels(delta)


func load_file(file):
	
	var f = FileAccess.open(file, FileAccess.READ)
	var index = 1
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		line += " "
		
		textArray.append(line)
		
		index += 1
	f.close()
	return


func createLabel():
	if (workingTextArray.is_empty()):
		workingTextArray = textArray.duplicate()
		workingTextArray.shuffle()

	var obj = labelObj.instantiate()
	call_deferred("add_child", obj)
	
	obj.position.x = position.x + size.x
	
	var label := obj.get_child(0)
	label.text = workingTextArray[0]
	workingTextArray.pop_front()
	
	
func moveLabels(delta):
	for children in get_children():
		children.position.x += scrollSpeed * delta
		if (!children.passed && ((children.position.x + children.get_child(0).size.x) + (size.x / 7) < (position.x + size.x))):
			createLabel()
			children.passed = true;
		if ((children.position.x + children.get_child(0).size.x) < position.x):
			call_deferred("remove_child", children)
