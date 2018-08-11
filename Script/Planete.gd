extends Node2D

var Helper=preload("Helper.gd")

var planetes=[preload("res://Art/Planete_01.png"), preload("res://Art/Planete_02.png"), preload("res://Art/Planete_03.png"), preload("res://Art/Planete_04.png"), preload("res://Art/Planete_05.png"), preload("res://Art/Planete_06.png"), preload("res://Art/Planete_07.png")]
var planetes_index=0

var maxHumans=20
var humans=0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func reset():
	var rN=Helper.rand_between(0, planetes.size()-1)

	if rN==planetes_index:
		var rN1=Helper.rand_between(0, 1)
		if rN1==1:
			if rN==planetes.size()-1:
				planetes_index=0
			else:
				planetes_index+=1
		else:
			if rN==0:
				planetes_index=planetes.size()-1
			else:
				planetes_index-=1
	else:
		planetes_index=rN

	$Sprite.texture=planetes[planetes_index]
	humans=Helper.rand_between(0, maxHumans)
	$Label.text=str(humans)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	humans=Helper.rand_between(0, maxHumans)
	$Label.text=str(humans)
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
