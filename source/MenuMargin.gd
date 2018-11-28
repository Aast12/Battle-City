extends MarginContainer

export (PackedScene) var story

var counter = 0
var time = 0

func _ready():
	pass

func _process(delta):
	pass

func _on_NewGameLabel_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_LoadGameLabel_pressed():
	pass # replace with function body


func _on_QuitLabel_pressed():
	get_tree().quit()
