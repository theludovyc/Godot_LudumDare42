extends Node2D

var Helper=preload("Helper.gd")

var maxHumans=20
var humans=0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func reset():
	humans=Helper.rand_between(0, maxHumans)
	$Label.text=str(humans)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	reset()
	pass

func isFullHumans():
	if humans==maxHumans:
		return true
	return false

func addHumans(h):
	humans+=h
	$Label.text=str(humans)

func getRatioHumans():
	return humans/float(maxHumans)

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
