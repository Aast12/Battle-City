extends CanvasLayer

func _ready():
	$Panel.hide()

func _on_Continue_pressed():
	get_tree().set_pause(false)
	$Panel.hide()

func _on_Save_pressed():
	print("lmao")

func _on_Quit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://MainMenu.tscn")