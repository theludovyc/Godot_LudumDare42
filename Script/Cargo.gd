extends Node2D

signal teleported
signal upgraded

export(int) var startPos=0
export(int) var endPos=100

export(bool) var sound=false

var onTeleport=false

var upgradeChance=0.1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if sound:
		$Audio.play()

	pass

func canVacuum():
	if modulate.a==1:
		return true
	return false

func upgrade():
	$Node_Cargo.upgrade(global.level)
	global.level+=1

func onTimer_timeout():
	if onTeleport:
		if modulate.a>0:
			modulate.a-=0.1
			$Audio.volume_db-=2
		else:
			if global.level<3:
				var r=randf()
				if r<=upgradeChance:
					upgrade()
					upgradeChance=0.1
					emit_signal("upgraded")
				else:
					upgradeChance+=0.1

			position.x=startPos
			onTeleport=false
			emit_signal("teleported")
	else:
		if modulate.a<1:
			modulate.a+=0.1
			$Audio.volume_db+=2
		else:
			$Timer.stop()

func _process(delta):
	position.x+=40*delta

	if position.x>endPos and !onTeleport:
		$Timer.start()
		onTeleport=true
	pass

func setBarre0(var v):
	$Node_Cargo.setScale_Barre0(v)

func setBarre1(var v):
	$Node_Cargo.setScale_Barre1(v)

func setBarre2(var v):
	$Node_Cargo.setScale_Barre2(v)

func setBarre3(var v):
	$Node_Cargo.setScale_Barre3(v)

func setHalo(i, b):
	$Node_Cargo.setVisibility_Halo(i, b)

func setBarre(i, v):
	$Node_Cargo.setScale_Barre(i, v)

func setHaloRed(i):
	$Node_Cargo.setColor_Halo_Red(i)

func setHaloWhite(i):
	$Node_Cargo.setColor_Halo_White(i)

func setHaloDefault(i):
	$Node_Cargo.setColor_Halo_Default(i)