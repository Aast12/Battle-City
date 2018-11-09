extends StaticBody2D

func _on_Area2D_body_entered(body):
	if Input.is_key_pressed(KEY_Z):
		print ("Cagajo")
	print(2)
