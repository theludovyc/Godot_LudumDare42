extends Node

var humans=0

var pressA=false
var pressQ=false
var trappe=0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func onTimer_timeout():
	match trappe:
		1:
			humans+=1
		2:
			if humans>0:
				humans-=1

	$Label4.text=str(humans)

func _process(delta):
	if Input.is_action_just_pressed("Key_A"):
		pressA=true
		trappe=1
		$Timer.start()

		$Label.text="1"
		$Label3.text="Aspire"

	if Input.is_action_just_released("Key_A"):
		pressA=false
		$Label.text="0"

		if !pressQ:
			trappe=0
			$Label3.text="Ne fait rien"
		else:
			trappe=2
			$Label3.text="Expulse"

	if Input.is_action_just_pressed("Key_Q"):
		pressQ=true
		trappe=2
		$Timer.start()

		$Label2.text="1"
		$Label3.text="Expulse"

	if Input.is_action_just_released("Key_Q"):
		pressQ=false
		$Label2.text="0"

		if !pressA:
			trappe=0
			$Label3.text="Ne fait rien"
		else:
			trappe=1
			$Label3.text="Aspire"
	pass
