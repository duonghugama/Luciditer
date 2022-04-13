extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const maxFallSpeed = 200;
const maxSpeed = 80
const jumpForce = 300
const accel = 10

var motion = Vector2.ZERO

func _ready() -> void:
	$AnimationTree.active = true

func get_input():
	motion.y += gravity
	if(motion.y > maxFallSpeed):
		motion.y = maxFallSpeed
	
	motion.x = clamp(motion.x, -maxSpeed , maxSpeed)
	
	if Input.is_action_pressed("ui_left"):
		motion.x -= accel
	elif Input.is_action_pressed("ui_right"):
		motion.x += accel 
	else:
		motion.x = lerp(motion.x,0,0.2)
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -jumpForce
	motion = move_and_slide(motion)
func _physics_process(delta: float) -> void:
	get_input()
