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

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
