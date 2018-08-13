extends Node

export(bool) var sound=false

var maxHumans=20
var humans=10

var pressA=false
var pressQ=false
var trappe=0

var score=0

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
		$Cargo.setHalo0(true)

		match trappe:
			1:
				if $Planete.haveHumans():
					$Planete.takeHumans(1)
					if humans==maxHumans:
						$Cargo.setHalo0Red()
						score-=3
						$Score.text=str(score)
					else:
						$Cargo.setHalo0Yellow()
						humans+=1
			2:
				humans-=1
				if humans==0:
					global.score=score
					get_tree().change_scene("res://Scene/Win.tscn")

				if $Planete.isFullHumans():
					$Cargo.setHalo0Red()
					score-=3
					$Score.text=str(score)
				else:
					$Cargo.setHalo0White()
					$Planete.addHumans(1)

		$Label4.text=str(humans)
		resetCargoBarr0()
		if sound:
			$Beep.play()
	else:
		$Cargo.setHalo0(false)

func onTimer2_timeout():
	score+=1
	$Score.text=str(score)

func onCargo_teleported():
	if $Planete.haveHumans():
		var ratio=$Planete.getRatioHumans()

		if ratio<1:
			if ratio==0.5:
				score+=7
			elif ratio>=0.4 and ratio<=0.6:
				score+=6
			elif ratio>=0.3 and ratio<=0.7:
				score+=5
			elif ratio>=0.2 and ratio<=0.8:
				score+=4
			elif ratio>=0.1 and ratio<=0.9:
				score+=3
			else:
				score+=2

			$Score.text=str(score)

	$Planete.reset()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_pressed("Halo0_Vacuum"):
		pressA=true
		trappe=1
		
		$Timer.start()

		$Label.text="1"
		$Label3.text="Vacuum"

	if Input.is_action_just_released("Halo0_Vacuum"):
		pressA=false
		$Label.text="0"

		if !pressQ:
			trappe=0
			$Cargo.setHalo0(false)
			$Timer.stop()
			$Label3.text="Do nothing"
		else:
			trappe=2
			$Label3.text="Deport"

	if Input.is_action_just_pressed("Halo0_Deport"):
		pressQ=true
		trappe=2

		$Timer.start()

		$Label2.text="1"
		$Label3.text="Deport"

	if Input.is_action_just_released("Halo0_Deport"):
		pressQ=false
		$Label2.text="0"

		if !pressA:
			trappe=0
			$Cargo.setHalo0(false)
			$Timer.stop()
			$Label3.text="Do nothing"
		else:
			trappe=1
			$Label3.text="Vacuum"
	pass
