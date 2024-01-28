extends Control

@export var blinkTime = 1.5
@export var scrollTime = 3
@onready var liveSign := $AspectRatioContainer/LiveSign
@onready var death_toll_number_label := $TextureRect/deathTollNumberLabel

var curTime

func update_death_display(num: int):
	death_toll_number_label.text = str(num)
	print(str(num))

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
