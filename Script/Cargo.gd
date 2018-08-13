extends Node2D

signal teleported

export(int) var startPos=0
export(int) var endPos=100

export(bool) var sound=false

var onTeleport=false

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

func onTimer_timeout():
	if onTeleport:
		if modulate.a>0:
			modulate.a-=0.1
			$Audio.volume_db-=2
		else:
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

func setHalo0(var b):
	$Node_Cargo.setVisibility_Halo0(b)

func setHalo0Yellow():
	$Node_Cargo.setColor_Halo0_Yellow()

func setHalo0Red():
	$Node_Cargo.setColor_Halo0_Red()

func setHalo0White():
	$Node_Cargo.setColor_Halo0_White()

func setBarre0(var v):
	$Node_Cargo.setScale_Barre0(v)