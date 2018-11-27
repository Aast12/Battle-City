extends CanvasLayer

func _ready():
	pass

func _on_Continue_pressed():
	get_tree().set_pause(false)
	layer = -50

func _on_Save_pressed():
	pass

func _on_Quit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://MainMenu.tscn")