extends KinematicBody

onready var Camera = $Camera

var velocity = Vector3()
var speed = 10
var max_speed = 100
var turn_sensitivity = 2
var rot_sensitivity = 20

var turning = 0
var pitching = 0
var decay = 0.5

var rot_x = 0.0
var rot_y = 0.0
var rot_z = 0.0

func _ready():
	pass

func get_input(delta):
	if Input.is_action_pressed("Up"):
		rot_x += rot_sensitivity * delta
	if Input.is_action_pressed("Down"):
		rot_x -= rot_sensitivity * delta
	if Input.is_action_pressed("Left"):
		rot_y += rot_sensitivity * delta
		turning += turn_sensitivity
	if Input.is_action_pressed("Right"):
		rot_y -= rot_sensitivity * delta
		turning -= turn_sensitivity
	turning = clamp(turning, -30.0, 30.0)


func _physics_process(delta):
	get_input(delta)

	turning = sign(turning) * (abs(turning) - decay)
	if abs(turning) < decay: turning = 0
	
	rotation_degrees.x = rot_x
	rotation_degrees.y = rot_y
	rotation_degrees.z = turning
	
	translate(-$Reference.transform.basis.z * speed * delta)
