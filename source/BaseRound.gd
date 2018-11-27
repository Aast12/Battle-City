extends CanvasLayer

var round_level
var kill_counter
var time 
var is_fading = false
var opacity_val = 1

func init(lvl):
	round_level = lvl
	$InitPanel/RoundLabel.set_text("Round " + str(round_level))
	#$InitPanel/RoundDescription.set_text(description)
	$InitPanel.show()
	$ResultsPanel.hide()
	$ShowTime.wait_time = 6
	$ShowTime.start()

func check():
	pass

func end():
	$ResultsPanel/Data/Time.set_text(time)
	$ResultsPanel/Data/KillCount.set_text(str(kill_counter))
	$ResultsPanel/Labels/RoundLevel.set_text(str(round_level))
	$InitPanel.hide()
	$ResultsPanel.show()
	get_parent().get_tree().set_pause(true)

func _ready():
	pass

func _process(delta):
	if is_fading:
		$CanvasModulate.color = Color(1, 1, 1, opacity_val)
		opacity_val -= delta
		

func _on_Button_pressed():
	get_tree().set_pause(false)
	queue_free()


func _on_ShowTime_timeout():
	is_fading = true
