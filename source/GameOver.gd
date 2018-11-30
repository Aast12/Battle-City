extends CanvasLayer


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
	get_tree().set_pause(false)

func _on_QuitButton_pressed():
	get_tree().quit()
