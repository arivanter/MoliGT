extends "res://Automovil/Automovil/Automovil.gd"

var cam = load('res://Interaccion/HUD/Camera.tscn').instance()


func _ready():
	$Name.text = record.data.racer_name
	is_player = true
	add_child(cam)
	add_child(load('res://Interaccion/HUD/HUD.tscn').instance())

func _physics_process(delta):
	if Input.is_action_pressed("Accelerate"):
		accel()
		
	if Input.is_action_just_released("Accelerate") or Input.is_action_just_released("Reverse"):
		stop()
		
	if Input.is_action_pressed("Reverse"):
		reverse()
		
	if Input.is_action_pressed("ui_right"):
		if steering_const < 0:
			steering_const = -steering_const
		steer()
	
	if Input.is_action_pressed("ui_left"):
		if steering_const > 0:
			steering_const = -steering_const
		steer()
	
	if Input.is_action_just_pressed("Engine"):
		switch_engine()
		


#func _process(delta):
#	print(str(position.x) +',' + str(position.y)+','+str(rot))
	