extends CanvasLayer

signal spawn_enemies(amount)
signal end_wave

var round_level = 0
var kill_counter = 0
var current_kills = 0
var time = 0
var survive_time = 60
var is_fading = false
var opacity_val = 1
var active = true
var generate = 0
var show_time = 5
var first_check = true

func init(lvl, current_points):
	round_level = lvl
	current_kills = current_points
	$InitPanel/RoundLabel.set_text("Round " + str(round_level))
	$InitPanel/RoundDescription.set_text("Survive")
	$InitPanel.show()
	$ResultsPanel.hide()
	$ShowTime.wait_time = show_time
	$ShowTime.start()
	$Timer.hide()
	$RoundTime.wait_time = survive_time + (lvl - 1) * 15
	generate = lvl * 5 + 10
	emit_signal("spawn_enemies", generate)

func check(points):
	kill_counter = points - current_kills
	if (generate * 3) / 4 <= kill_counter:
		emit_signal("spawn_enemies", generate / 2)
		generate = kill_counter + generate / 2

func end():
	get_tree().call_group("enemies", "destroy")
	$ResultsPanel/Data/Time.set_text(str(int(time) / 60).pad_zeros(2) + " : " + str(int(time) % 60).pad_zeros(2))
	$ResultsPanel/Data/KillCount.set_text(str(kill_counter))
	$ResultsPanel/Data/RoundLevel.set_text(str(round_level))
	$InitPanel.hide()
	$ResultsPanel.show()
	get_tree().set_pause(true)

func _ready():
	pass

func _process(delta):
	$Timer.text = str(int($RoundTime.time_left) / 60).pad_zeros(2) + " : " + str(int($RoundTime.time_left) % 60).pad_zeros(2)
	if is_fading:
		$InitPanel.modulate = Color(1, 1, 1, opacity_val)
		opacity_val -= delta
		if opacity_val <= 0:
			is_fading = false
			$InitPanel.hide()
			$ShowTime.stop()
			$Timer.show()
	time += delta
		

func _on_Button_pressed():
	get_tree().set_pause(false)
	queue_free()


func _on_ShowTime_timeout():
	is_fading = true
	$RoundTime.start()
	time = 0


func _on_RoundTime_timeout():
	$RoundTime.stop()
	$Timer.hide()
	emit_signal("end_wave")
	end()