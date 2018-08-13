extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setVisibility_Halo0(var b):
	$Halo_0.visible=b

func setColor_Halo0_Yellow():
	$Halo_0.self_modulate=Color(1, 1, 0)

func setColor_Halo0_Red():
	$Halo_0.self_modulate=Color(1, 0, 0)

func setColor_Halo0_White():
	$Halo_0.self_modulate=Color(1, 1, 1)

func setScale_Barre0(var v):
	$Barre_0.scale.x=v

func upgrade(var v):
	match v:
		0:
			$Droite_0.hide()
			$Milieu_0.show()
			$Barre_01.show()
			$Barre_1.show()
			$Droite_1.show()

func setVisibility_Halo1(var b):
	$Halo_1.visible=b

func setScale_Barre1(var v):
	$Barre_1.scale.x=v

func setVisibility_Halo(i, b):
	match i:
		0:
			$Halo_0.visible=b
		1:
			$Halo_1.visible=b

func setScale_Barre(i, v):
	match i:
		0:
			$Barre_0.scale.x=v
		1:
			$Barre_1.scale.x=v

func setColor_Halo_Red(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 0, 0)
		1:
			$Halo_1.self_modulate=Color(1, 0, 0)

func setColor_Halo_White(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 1, 1)
		1:
			$Halo_1.self_modulate=Color(1, 1, 1)

func setColor_Halo_Default(i):
	match i:
		0:
			$Halo_0.self_modulate=Color(1, 1, 0)
		1:
			$Halo_1.self_modulate=Color(0.78, 0, 1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
