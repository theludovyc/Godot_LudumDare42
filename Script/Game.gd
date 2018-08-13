extends Node

export(bool) var sound=false

var maxHumans=20
var humans=10

var pressA=false
var pressQ=false
var trappe0=0

var score=0

var maxKrogans=20
var krogans=0

var pressZ=false
var pressS=false
var trappe1=0

var trappes=[0, 0]
var races=[10, 0]
var maxRaces=[20, 20]

func resetCargoBarre(i):
	match i:
		0:
			if races[0]>0:
				$Cargo.setBarre0(races[0]/float(maxRaces[0]))
			else:
				$Cargo.setBarre0(0)
		1:
			if races[1]>0:
				$Cargo.setBarre1(races[1]/float(maxRaces[1]))
			else:
				$Cargo.setBarre1(0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Label4.text=str(humans)
	resetCargoBarre(0)
	pass

func checkWin():
	for i in range(0, races.size()):
		if races[i]>0:
			return

	global.score=score
	get_tree().change_scene("res://Scene/Win.tscn")

func onTimeout(i):
	if $Cargo.canVacuum():
		$Cargo.setHalo(i, true)

		match trappes[i]:
			1:
				if $Planete.haveRaces(i):
					$Planete.addRaces(i, -1)
					if races[i]==maxRaces[i]:
						$Cargo.setHaloRed(i)
						score-=3
						$Score.text=str(score)
					else:
						$Cargo.setHaloDefault(i)
						races[i]+=1
			2:
				races[i]-=1
				if races[i]==0:
					checkWin()

				if $Planete.isFullRaces(i):
					$Cargo.setHaloRed(i)
					score-=3
					$Score.text=str(score)
				else:
					$Cargo.setHaloWhite(i)
					$Planete.addRaces(i, 1)

		resetCargoBarre(i)
		if sound:
			$Beep.play()
	else:
		$Cargo.setHalo(i, false)

func onTimer_timeout():
	onTimeout(0)

func onTimer1_timeout():
	onTimeout(1)

func onTimerScore_timeout():
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
		trappes[0]=1
		
		$Timer.start()

		$Label.text="1"
		$Label3.text="Vacuum"

	if Input.is_action_just_released("Halo0_Vacuum"):
		pressA=false
		$Label.text="0"

		if !pressQ:
			trappes[0]=0
			$Cargo.setHalo(0, false)
			$Timer.stop()
			$Label3.text="Do nothing"
		else:
			trappes[0]=2
			$Label3.text="Deport"

	if Input.is_action_just_pressed("Halo0_Deport"):
		pressQ=true
		trappes[0]=2

		$Timer.start()

		$Label2.text="1"
		$Label3.text="Deport"

	if Input.is_action_just_released("Halo0_Deport"):
		pressQ=false
		$Label2.text="0"

		if !pressA:
			trappes[0]=0
			$Cargo.setHalo(0, false)
			$Timer.stop()
			$Label3.text="Do nothing"
		else:
			trappes[0]=1
			$Label3.text="Vacuum"

	if global.level>0:
		if Input.is_action_just_pressed("Halo1_Vacuum"):
			pressZ=true
			trappes[1]=1
			
			$Timer1.start()

		if Input.is_action_just_released("Halo1_Vacuum"):
			pressZ=false

			if !pressS:
				trappes[1]=0
				$Cargo.setHalo(1, false)
				$Timer1.stop()
			else:
				trappes[1]=2

		if Input.is_action_just_pressed("Halo1_Deport"):
			pressS=true
			trappes[1]=2

			$Timer.start()

		if Input.is_action_just_released("Halo1_Deport"):
			pressS=false

			if !pressZ:
				trappes[1]=0
				$Cargo.setHalo(1, false)
				$Timer.stop()
			else:
				trappes[1]=1
	pass
