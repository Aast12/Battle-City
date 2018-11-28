extends KinematicBody2D

export (int) var speed = 20

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _process(delta):
    get_input()
    move_and_slide(velocity)