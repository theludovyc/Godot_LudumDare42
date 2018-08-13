extends Node2D

var Helper=preload("Helper.gd")

var planetes=[preload("res://Art/Planete/Planete_01.png"), preload("res://Art/Planete/Planete_02.png"), preload("res://Art/Planete/Planete_03.png"), preload("res://Art/Planete/Planete_04.png"), preload("res://Art/Planete/Planete_05.png"), preload("res://Art/Planete/Planete_06.png"), preload("res://Art/Planete/Planete_07.png")]
var planetes_index=0

var races=[0, 0]
var maxRaces=[20, 20]

var maxHumans=20
var humans=0

var maxKrogans=20
var krogans=0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setBarre(i):
	match i:
		0:
			$Barre_0.scale.x=(races[0]/float(maxRaces[0]))
		1:
			$Barre_1.scale.x=(races[1]/float(maxRaces[1]))

func setBarre0():
	$Barre_0.scale.x=(races[0]/float(maxRaces[0]))

func setBarre1():
	$Barre_1.scale.x=(races[1]/float(maxRaces[1]))

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

	races[0]=Helper.rand_between(1, maxRaces[0])
	setBarre0()

	if global.level>0:
		races[1]=Helper.rand_between(1, maxRaces[1])
		setBarre1()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	races[0]=Helper.rand_between(1, maxRaces[0])
	setBarre0()
	pass

#Humans
func isFullHumans():
	if humans==maxHumans:
		return true
	return false

func addHumans(h):
	humans+=h
	$Label.text=str(humans)
	setBarre0()

func getRatioHumans():
	return humans/float(maxHumans)

func haveHumans():
	if humans>0:
		return true
	return false

func takeHumans(h):
	humans-=h
	$Label.text=str(humans)
	setBarre0()

#Krogans
func haveKrogans():
	if krogans>0:
		return true
	return false

func isFullKrogans():
	if krogans==maxKrogans:
		return true
	return false

func addKrogans(k):
	krogans+=k
	setBarre1()

func takeKrogans(k):
	krogans-=k
	setBarre1()

func getRatioKrogans():
	return krogans/float(maxKrogans)

#Races
func haveRaces(i):
	if races[i]>0:
		return true
	return false

func isFullRaces(i):
	if races[i]==maxRaces[i]:
		return true
	return false

func addRaces(i, v):
	races[i]+=v
	setBarre(i)

func getRatioRaces(i):
	return races[i]/float(maxRaces[i])

func onCargo_upgraded():
	match global.level:
		1:
			$Sprite2.position.x=672
			$Barre_0.position.x=672
			$Sprite3.show()
			$Barre_1.show()