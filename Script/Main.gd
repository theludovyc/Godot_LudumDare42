extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_pressed("Halo0_Vacuum"):
		get_tree().change_scene("res://Scene/Game.tscn")

	if Input.is_action_just_pressed("Halo0_Deport"):
		var v=InputMap.get_action_list("Halo0_Vacuum")
		v[0].scancode=KEY_Q

		v=InputMap.get_action_list("Halo0_Deport")
		v[0].scancode=KEY_A

		v=InputMap.get_action_list("Halo1_Vacuum")
		v[0].scancode=KEY_W

		get_tree().change_scene("res://Scene/Game.tscn")
	pass
