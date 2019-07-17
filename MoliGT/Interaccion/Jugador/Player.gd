extends "res://Automovil/Automovil/Automovil.gd"


var hud = load('res://Interaccion/HUD/HUD.tscn').instance()
var cam = load('res://Interaccion/HUD/Camera.tscn').instance()

func _ready():
	$Name.text = record.data.racer_name
	add_child(hud)
	add_child(cam)
	is_player = true

func _physics_process(delta):
	if (is_network_master()):
		if Input.is_action_pressed("Accelerate"):
			rpc_unreliable('accel')
			
		if Input.is_action_just_released("Accelerate") or Input.is_action_just_released("Reverse"):
			rpc_unreliable('stop')
			
		if Input.is_action_pressed("Reverse"):
			rpc_unreliable('reverse')
			
		if Input.is_action_pressed("ui_right"):
			if steering_const < 0:
				steering_const = -steering_const
			rpc_unreliable('steer',steering_const)
		
		if Input.is_action_pressed("ui_left"):
			if steering_const > 0:
				steering_const = -steering_const
			rpc_unreliable('steer',steering_const)
		
		if Input.is_action_just_pressed("Engine"):
			rpc_unreliable('switch_engine')
		
		rpc_unreliable('setpos',position, rot)

func start():
	rpc_unreliable('switch_engine')

#func _process(delta):
#	print(str(position.x) +',' + str(position.y)+','+str(rot))
	