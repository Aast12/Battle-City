extends CanvasLayer

signal spawn_enemies(amount)
signal end_wave

var round_level = 0
var kill_counter = 0
var current_kills = 0
var kill_goal = 0
var time = 0
var is_fading = false
var opacity_val = 1
var show_time = 5
var generate = 0

func init(lvl, current_points):
	round_level = lvl
	current_kills = current_points
	kill_goal = (lvl - 1) * 5 + 10
	$InitPanel/RoundLabel.set_text("Round " + str(round_level))
	$InitPanel/RoundDescription.set_text("Eliminate " + str(kill_goal) + " enemies")
	$InitPanel.show()
	$ResultsPanel.hide()
	$ShowTime.wait_time = show_time
	$ShowTime.start()
	generate = lvl * 2 + 10
	emit_signal("spawn_enemies", generate)

func check(points):
	kill_counter = points - current_kills
	if kill_counter >= kill_goal:
		emit_signal("end_wave")
		end()
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
	if is_fading:
		$InitPanel.modulate = Color(1, 1, 1, opacity_val)
		opacity_val -= delta
		if opacity_val <= 0:
			is_fading = false
			$InitPanel.hide()
			$ShowTime.stop()
	time += delta
		

func _on_Button_pressed():
	get_tree().set_pause(false)
	queue_free()

func _on_ShowTime_timeout():
	is_fading = true
