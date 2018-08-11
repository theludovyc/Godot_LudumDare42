extends Node2D

signal teleported

export(int) var startPos=0
export(int) var endPos=100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func canVacuum():
	return true

func _process(delta):
	position.x+=40*delta

	if position.x>endPos:
		emit_signal("teleported")
		position.x=startPos
	pass
