extends CanvasLayer

func _ready(delta):

	get_node("HP").text = str(get_parent().get_parent().hp)
	get_node("STAMINA").text = str(get_parent().get_parent().stamina)
