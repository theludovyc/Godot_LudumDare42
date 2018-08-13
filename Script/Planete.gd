extends Node2D

var Helper=preload("Helper.gd")

var planetes=[preload("res://Art/Planete/Planete_01.png"), preload("res://Art/Planete/Planete_02.png"), preload("res://Art/Planete/Planete_03.png"), preload("res://Art/Planete/Planete_04.png"), preload("res://Art/Planete/Planete_05.png"), preload("res://Art/Planete/Planete_06.png"), preload("res://Art/Planete/Planete_07.png")]
var planetes_index=0

var races=[0, 0, 0, 0]
var maxRaces=[20, 20, 20, 20]

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setBarre(i):
	match i:
		0:
			$Barre_0.scale.x=(races[0]/float(maxRaces[0]))
		1:
			$Barre_1.scale.x=(races[1]/float(maxRaces[1]))
		2:
			$Barre_2.scale.x=(races[2]/float(maxRaces[2]))
		3:
			$Barre_3.scale.x=(races[3]/float(maxRaces[3]))

func resetRaces(i):
	races[i]=Helper.rand_between(1, maxRaces[i])
	setBarre(i)

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

	match global.level:
		3:
			resetRaces(0)
			resetRaces(1)
			resetRaces(2)
			resetRaces(3)
		2:
			resetRaces(0)
			resetRaces(1)
			resetRaces(2)
		1:
			resetRaces(0)
			resetRaces(1)
		0:
			resetRaces(0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	races[0]=Helper.rand_between(1, maxRaces[0])
	$Barre_0.scale.x=(races[0]/float(maxRaces[0]))
	pass

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
			#972
			$Sprite3.show()
			$Barre_1.show()

		2:
			$Sprite2.position.x=472
			$Barre_0.position.x=472
			$Sprite3.position.x=800
			$Barre_1.position.x=800
			#1128
			$Sprite4.show()
			$Barre_2.show()

		3:
			$Sprite2.position.x=316
			$Barre_0.position.x=316
			$Sprite3.position.x=644
			$Barre_1.position.x=644
			$Sprite4.position.x=972
			$Barre_2.position.x=972
			$Sprite5.show()
			$Barre_3.show()
