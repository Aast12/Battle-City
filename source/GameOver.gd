extends CanvasLayer


func _ready():
	pass

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
