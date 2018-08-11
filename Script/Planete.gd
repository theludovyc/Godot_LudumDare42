extends Node2D

var humans=10

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Label.text=str(humans)
	pass

func addHumans(h):
	humans+=h
	$Label.text=str(humans)

func haveHumans():
	if humans>0:
		return true
	return false

func takeHumans(h):
	humans-=h
	$Label.text=str(humans)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
