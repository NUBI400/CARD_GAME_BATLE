extends RigidBody3D

@onready var raycasts = $Raycasts.get_children()

var is_rolling = false

var start_pos

# FAZER UM SISTEMA DE QUANTO MAIS EU CLICKAR NA TELA MAIS FORTE E A ROLL_STRENGHT
var roll_strength = 30

signal roll_finished(value)

func _ready():
	start_pos = global_position

func _input(event):
	if event.is_action_pressed("mouse1"):
		_roll()

func _roll():
	
	#Reset stae
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	#Random rotation
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2 * PI)) * transform.basis
	
	#Randow throw impulse
	var throw_vector = Vector3(randf_range(-1,1), 0, randf_range(-1, 1)).normalized()
	angular_velocity = throw_vector * roll_strength / 2
	apply_central_impulse(throw_vector * roll_strength)
	is_rolling = true
	


func _on_sleeping_state_changed():
	if sleeping:
		var landed_on_side = false
		for raycast in raycasts:
			if raycast.is_colliding():
				roll_finished.emit(raycast.opposite_side)
				is_rolling = false
				landed_on_side = true
		
		if !landed_on_side:
			_roll()
