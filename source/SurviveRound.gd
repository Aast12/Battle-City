extends CanvasLayer

signal spawn_enemies(amount)
signal end_wave

var round_level
var kill_counter = 0
var time = 0
var is_fading = false
var opacity_val = 1
var active = true
var generate = 0

func init(lvl):
	round_level = lvl
	$InitPanel/RoundLabel.set_text("Round " + str(round_level))
	#$InitPanel/RoundDescription.set_text(description)
	$InitPanel.show()
	$ResultsPanel.hide()
	$ShowTime.wait_time = 6
	$ShowTime.start()
	$Timer.hide()
	$RoundTime.wait_time = 120
	var amount = lvl * 5 + 10
	emit_signal("spawn_enemies", amount)

func check(points):
	kill_counter = points

func end():
	$ResultsPanel/Data/Time.set_text(str(time))
	$ResultsPanel/Data/KillCount.set_text(str(kill_counter))
	$ResultsPanel/Labels/RoundLevel.set_text(str(round_level))
	$InitPanel.hide()
	$ResultsPanel.show()

func _ready():
	pass

func _process(delta):
	$Timer.text = str(int($RoundTime.time_left) / 60).pad_zeros(2) + " : " + str(int($RoundTime.time_left) % 60).pad_zeros(2)
	if is_fading:
		#$CanvasModulate.color = Color(1, 1, 1, opacity_val)
		$InitPanel.modulate = Color(1, 1, 1, opacity_val)
		opacity_val -= delta
		if opacity_val <= 0:
			is_fading = false
			$InitPanel.hide()
			$ShowTime.stop()
			$Timer.show()
	time += delta
		

func _on_Button_pressed():
	active = false
	queue_free()


func _on_ShowTime_timeout():
	is_fading = true
	$RoundTime.start()
	time = 0


func _on_RoundTime_timeout():
	emit_signal("end_wave")
	end()
