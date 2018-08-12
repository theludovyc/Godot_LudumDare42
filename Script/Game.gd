extends Node

var maxHumans=20
var humans=10

var pressA=false
var pressQ=false
var trappe=0

var score=0

var state=0

func resetCargoBarr0():
	if humans>0:
		$Cargo.setBarre0(humans/float(maxHumans))

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Label4.text=str(humans)
	resetCargoBarr0()
	pass

func onTimer_timeout():
	if $Cargo.canVacuum():
		match trappe:
			1:
				if humans<maxHumans and $Planete.haveHumans():
					$Planete.takeHumans(1)
					humans+=1
			2:
				if humans>0 and !$Planete.isFullHumans():
					humans-=1
					$Planete.addHumans(1)
					if humans==0:
						$Label5.text="Win"

		if trappe>0:
			$Label4.text=str(humans)
			resetCargoBarr0()
			$Beep.play()

func onCargo_teleported():
	if $Planete.haveHumans():
		var ratio=$Planete.getRatioHumans()

		if ratio==0.5:
			score+=4
		elif ratio>0.45 and ratio<0.55:
			score+=3
		elif ratio>0.75 or ratio<0.25:
			score+=1
		else:
			score+=2

		$Label6.text=str(score)

	$Planete.reset()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_pressed("Key_A"):
		pressA=true
		trappe=1
		$Cargo.setHalo0(true)
		$Timer.start()

		$Label.text="1"
		$Label3.text="Vacuum"

	if Input.is_action_just_released("Key_A"):
		pressA=false
		$Label.text="0"

		if !pressQ:
			trappe=0
			$Cargo.setHalo0(false)
			$Label3.text="Do nothing"
		else:
			trappe=2
			$Cargo.setHalo0(true)
			$Label3.text="Deport"

	if Input.is_action_just_pressed("Key_Q"):
		pressQ=true
		trappe=2
		$Cargo.setHalo0(true)
		$Timer.start()

		$Label2.text="1"
		$Label3.text="Deport"

	if Input.is_action_just_released("Key_Q"):
		pressQ=false
		$Label2.text="0"

		if !pressA:
			trappe=0
			$Cargo.setHalo0(false)
			$Label3.text="Do nothing"
		else:
			trappe=1
			$Cargo.setHalo0(true)
			$Label3.text="Vacuum"
	pass
