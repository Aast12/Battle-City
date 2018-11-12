extends Label

var hud_stamina

func _process(delta):
	hud_stamina = get_parent().get_parent().get_parent().stamina
	text = str(hud_stamina)
	