extends Label

var hud_hp

func _process(delta):
	hud_hp = get_parent().hp 
	text = str(hud_hp)
	
	