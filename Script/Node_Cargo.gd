extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func upgrade(var v):
	match v:
		0:
			$Droite_0.hide()
			$Milieu_0.show()
			$Barre_01.show()
			$Barre_1.show()
			$Droite_1.show()
		1:
			$Droite_1.hide()
			$Milieu_1.show()
			$Barre_02.show()
			$Barre_2.show()
			$Droite_2.show()
		2:
			$Droite_2.hide()
			$Milieu_2.show()
			$Barre_03.show()
			$Barre_3.show()
			$Droite_3.show()

func setScale_Barre0(var v):
	$Barre_0.scale.x=v

func setScale_Barre1(var v):
	$Barre_1.scale.x=v

func setScale_Barre2(var v):
	$Barre_2.scale.x=v

func setScale_Barre3(var v):
	$Barre_3.scale.x=v

func setVisibility_Halo(i, b):
	match i:
		0:
			$Halo_0.visible=b
		1:
			$Halo_1.visible=b
		2:
			$Halo_2.visible=b
		3:
			$Halo_3.visible=b

func setScale_Barre(i, v):
	match i:
		0:
			$Barre_0.scale.x=v
		1:
			$Barre_1.scale.x=v
		2:
			$Barre_2.scale.x=v
		3:
			$Barre_3.scale.x=v

func setColor_Halo_Red(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 0, 0)
		1:
			$Halo_1.self_modulate=Color(1, 0, 0)
		2:
			$Halo_2.self_modulate=Color(1, 0, 0)
		3:
			$Halo_3.self_modulate=Color(1, 0, 0)

func setColor_Halo_White(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 1, 1)
		1:
			$Halo_1.self_modulate=Color(1, 1, 1)
		2:
			$Halo_2.self_modulate=Color(1, 1, 1)
		3:
			$Halo_3.self_modulate=Color(1, 1, 1)

func setColor_Halo_Default(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 1, 0)
		1:
			$Halo_1.self_modulate=Color(0.78, 0, 1)
		2:
			$Halo_2.self_modulate=Color(0, 1, 0)
		3:
			$Halo_3.self_modulate=Color(0, 1, 1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
