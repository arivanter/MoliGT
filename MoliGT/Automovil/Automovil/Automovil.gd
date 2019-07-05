extends KinematicBody2D


var is_player = false
var ID

var can_move
var engine
var speed = 200
var rev_speed = 50
var velocity = Vector2()
var base_accel = .03
var acceleration = base_accel
var reving = false
var moving = false
var steering_const = .1
var rot = 0
onready var smoke = $Sprite/Particles2D



func _ready():
	engine = false
	can_move = false
	smoke.emitting = false



func _physics_process(delta):
	$Sprite.rotation = -rot
	$CollisionShape2D.rotation = -rot



func accel ():
	if engine:
		if not reving:
			smoke.process_material.initial_velocity = 50
			smoke.amount = 15
			smoke.lifetime = .09
			
		velocity = get_front().normalized() * speed * acceleration
		velocity = move_and_slide(velocity)
		reving = true
		moving = true
		
		if acceleration < 1:
			acceleration += acceleration



func reverse ():
	if engine:
		if not reving:
			smoke.process_material.initial_velocity = 50
			smoke.amount = 15
			smoke.lifetime = .2
			
		velocity = get_front().normalized() * (-rev_speed) * acceleration
		velocity = move_and_slide(velocity)
		velocity.y = lerp(velocity.y, speed , acceleration)
		reving = true
		moving = true
		
		if acceleration < .3:
			acceleration += acceleration



func stop ():
	if engine:
		smoke.process_material.initial_velocity = 10
		smoke.amount = 10
		smoke.lifetime = 1
		reving = false
		moving = false
		acceleration = base_accel



func steer():
	if moving:
		rot -= steering_const



func switch_engine():
	if engine:
		can_move = false
		smoke.emitting = false
		engine = false
		moving = false
	else:
		can_move = true
		smoke.emitting = true
		engine = true



func get_front():
	return Vector2(cos(rot + PI/2.0), sin(rot - PI/2.0))