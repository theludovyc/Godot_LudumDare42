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

var press=[[false, false], [false, false]]

var timers

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
	timers=[$Timer, $Timer1]

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
				else:
					$Cargo.setHaloWhite(i)
					return
			2:
				if races[i]>0:
					races[i]-=1
					if races[i]==0:
						checkWin()
					else:	
						if $Planete.isFullRaces(i):
							$Cargo.setHaloRed(i)
							score-=3
							$Score.text=str(score)
						else:
							$Cargo.setHaloWhite(i)
							$Planete.addRaces(i, 1)
				else:
					$Cargo.setHaloWhite(i)
					return

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

func calcScoreRaces(i):
	if $Planete.haveRaces(i):
		var ratio=$Planete.getRatioRaces(i)

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

func onCargo_teleported():
	calcScoreRaces(0)

	if global.level>0:
		calcScoreRaces(1)

	$Score.text=str(score)
	$Planete.reset()

func onPress(a, a1, i):
	if Input.is_action_just_pressed(a):
		press[i][0]=true
		trappes[i]=1
		
		timers[i].start()

	if Input.is_action_just_released(a):
		press[i][0]=false

		if !press[i][1]:
			trappes[i]=0
			$Cargo.setHalo(i, false)
			timers[i].stop()
		else:
			trappes[i]=2

	if Input.is_action_just_pressed(a1):
		press[i][1]=true
		trappes[i]=2

		timers[i].start()

	if Input.is_action_just_released(a1):
		press[i][1]=false

		if !press[i][0]:
			trappes[i]=0
			$Cargo.setHalo(i, false)
			timers[i].stop()
		else:
			trappes[i]=1

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	onPress("Halo0_Vacuum", "Halo0_Deport", 0)

	if global.level>0:
		onPress("Halo1_Vacuum", "Halo1_Deport", 1)
	pass
